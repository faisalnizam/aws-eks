###################
###################
# Internet Gateway
###################
resource "aws_internet_gateway" "this" {
  count = var.create_vpc && length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.this[0].id

  tags = merge(
    {
      "Name" = join("-", compact([var.prefix, var.env, "igw", var.region, local.dependency_identifier["natgw"], local.tag_identifier["natgw"], local.tag_optional["natgw"]]))
    },
    var.tags,
    var.igw_tags,
  )
}

##############
# NAT Gateway
##############
# Workaround for interpolation not being able to "short-circuit" the evaluation of the conditional branch that doesn't end up being used
# Source: https://github.com/hashicorp/terraform/issues/11566#issuecomment-289417805
#
# The logical expression would be
#
#    nat_gateway_ips = var.reuse_nat_ips ? var.external_nat_ip_ids : aws_eip.nat.*.id
#
# but then when count of aws_eip.nat.*.id is zero, this would throw a resource not found error on aws_eip.nat.*.id.
locals {
  nat_gateway_ips = split(",", var.reuse_nat_ips ? join(",", var.external_nat_ip_ids) : join(",", [for nat_id in aws_eip.nat : nat_id.id]))
  one_nat         = zipmap([keys(var.public_subnets)[0]], [values(var.public_subnets)[0]])
}

resource "aws_eip" "nat" {
  for_each = var.create_vpc && var.enable_nat_gateway && false == var.reuse_nat_ips ? var.one_nat_gateway_per_az ? var.public_subnets : local.one_nat : {}

  vpc = true

  tags = merge(
    {
      "Name" = join("-", compact([var.prefix, var.env, "eipnat", var.region, local.dependency_identifier["eipnat"], local.tag_identifier["eipnat"], local.tag_optional["eipnat"], element(split("-", each.key), 2)]))

    },
    var.tags,
    var.nat_eip_tags,
  )
}

resource "aws_nat_gateway" "this" {
  for_each = var.create_vpc && var.enable_nat_gateway ? var.one_nat_gateway_per_az ? var.public_subnets : local.one_nat : {}

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = aws_subnet.public[each.value[0]].id
  tags = merge(
    {
      "Name" = join("-", compact([var.prefix, var.env, "natgw", var.region, local.dependency_identifier["natgw"], local.tag_identifier["natgw"], local.tag_optional["natgw"], element(split("-", each.key), 2)]))
    },
    var.tags,
    var.nat_gateway_tags,
  )

  depends_on = [aws_internet_gateway.this]
}

resource "aws_route" "private_nat_gateway" {
  for_each = var.attach_nat_gateway_to_rt && var.create_vpc && var.enable_nat_gateway ? var.one_nat_gateway_per_az ? var.private_subnets : local.one_nat : {}

  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[each.key].id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "loadbalancer_nat_gateway" {
  for_each = var.attach_nat_gateway_to_rt && var.create_vpc && var.enable_nat_gateway ? var.one_nat_gateway_per_az ? var.loadbalancer_subnets : local.one_nat : {}

  route_table_id         = aws_route_table.loadbalancer[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[each.key].id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "middleware_nat_gateway" {
  for_each = var.attach_nat_gateway_to_rt && var.create_vpc && var.enable_nat_gateway ? var.one_nat_gateway_per_az ? var.middleware_subnets : local.one_nat : {}

  route_table_id         = aws_route_table.middleware[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[each.key].id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "database_nat_gateway" {
  for_each = var.attach_nat_gateway_to_rt && var.create_vpc && var.enable_nat_gateway ? var.one_nat_gateway_per_az ? var.database_subnets : local.one_nat : {}

  route_table_id         = aws_route_table.database[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[each.key].id

  timeouts {
    create = "5m"
  }
}

###################
# TGW Attachment #
###################
resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_to_tgw_attachment" {
  count                                           = var.attach_vpc_to_tgw ? 1 : 0
  subnet_ids                                      = flatten(var.subnet_ids)
  transit_gateway_id                              = var.tgw_id
  vpc_id                                          = var.vpc_id
  transit_gateway_default_route_table_association = true
  transit_gateway_default_route_table_propagation = true

  tags = merge(
    {
      "Name" = join("-", compact([var.prefix, var.env, "tgw", var.region, "attachment", local.tag_optional["tgw_tags"]]))
    },
  )
}
