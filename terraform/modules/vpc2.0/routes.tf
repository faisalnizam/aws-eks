#################
# Publiс routes #
#################
resource "aws_route_table" "public" {
  count = var.create_vpc && length(var.public_subnets) > 0 ? 1 : 0
  #for_each = var.create_vpc && length(var.public_subnets) > 0 ? var.one_nat_gateway_per_az ? var.public_subnets : local.one_nat : {}

  vpc_id = aws_vpc.this[0].id

  tags = merge(
    {
      "Name" = join("-", compact([var.prefix, var.env, "rt", var.region, local.dependency_identifier["rt-public"], local.tag_identifier["rt-public"], local.tag_optional["rt-public"]]))
    },
    var.tags,
    var.public_route_table_tags,
  )
}

resource "aws_route" "public_internet_gateway" {
  count = var.create_vpc && length(var.public_subnets) > 0 ? 1 : 0
  #for_each = var.create_vpc && length(var.public_subnets) > 0 ? var.one_nat_gateway_per_az ? var.public_subnets : local.one_nat : {}

  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id

  timeouts {
    create = "5m"
  }
}

##################################################################
#                     Private routes                             #
# There are as many routing tables as the number of NAT gateways #
##################################################################
resource "aws_route_table" "private" {
  for_each = var.create_vpc && length(var.private_subnets) > 0 ? var.one_nat_gateway_per_az ? var.private_subnets : local.one_nat : {}

  vpc_id = aws_vpc.this[0].id

  tags = merge(
    {
      "Name" = join("-", compact([var.prefix, var.env, "rt", var.region, local.dependency_identifier["rt-private"], local.tag_identifier["rt-private"], local.tag_optional["rt-private"]]))
    },
    var.tags,
    var.private_route_table_tags,
  )
}

#######################
# Loadbalancer routes #
#######################

resource "aws_route_table" "loadbalancer" {
  for_each = var.create_vpc && length(var.loadbalancer_subnets) > 0 ? var.one_nat_gateway_per_az ? var.loadbalancer_subnets : local.one_nat : {}

  vpc_id = aws_vpc.this[0].id

  tags = merge(
    {
      "Name" = join("-", compact([var.prefix, var.env, "rt", var.region, local.dependency_identifier["rt-loadbalance"], local.tag_identifier["rt-loadbalance"], local.tag_optional["rt-loadbalance"]]))
    },
    var.tags,
    var.loadbalancer_route_table_tags,
  )
}


###################
# Database routes #
###################
resource "aws_route_table" "database" {
  for_each = var.create_vpc && length(var.database_subnets) > 0 ? var.one_nat_gateway_per_az ? var.database_subnets : local.one_nat : {}

  vpc_id = aws_vpc.this[0].id

  tags = merge(
    {
      "Name" = join("-", compact([var.prefix, var.env, "rt", var.region, local.dependency_identifier["rt-database"], local.tag_identifier["rt-database"], local.tag_optional["rt-database"]]))
    },
    var.tags,
    var.database_route_table_tags,
  )
}

#####################
# Middleware routes #
#####################
resource "aws_route_table" "middleware" {
  for_each = var.create_vpc && length(var.middleware_subnets) > 0 ? var.one_nat_gateway_per_az ? var.middleware_subnets : local.one_nat : {}

  vpc_id = aws_vpc.this[0].id

  tags = merge(
    {
      "Name" = join("-", compact([var.prefix, var.env, "rt", var.region, local.dependency_identifier["rt-middleware"], local.tag_identifier["rt-middleware"], local.tag_optional["rt-middleware"]]))
    },
    var.tags,
    var.middleware_route_table_tags,
  )
}

############################
# Route table associations #
############################
resource "aws_route_table_association" "private" {
  for_each = var.create_vpc && length(var.private_subnets) > 0 ? var.enable_nat_gateway && var.one_nat_gateway_per_az ? { for subnet in aws_subnet.private : subnet.cidr_block => subnet.availability_zone } : { for subnet in aws_subnet.private : subnet.cidr_block => keys(var.private_subnets)[0] } : {}

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.value].id
}

resource "aws_route_table_association" "loadbalancer" {
  for_each = var.create_vpc && length(var.loadbalancer_subnets) > 0 ? var.enable_nat_gateway && var.one_nat_gateway_per_az ? { for subnet in aws_subnet.pri_loadbalancer : subnet.cidr_block => subnet.availability_zone } : { for subnet in aws_subnet.pri_loadbalancer : subnet.cidr_block => keys(var.loadbalancer_subnets)[0] } : {}

  route_table_id = aws_route_table.loadbalancer[each.value].id
  subnet_id      = aws_subnet.pri_loadbalancer[each.key].id
}

resource "aws_route_table_association" "database" {
  for_each = var.create_vpc && length(var.database_subnets) > 0 ? var.enable_nat_gateway && var.one_nat_gateway_per_az ? { for subnet in aws_subnet.database : subnet.cidr_block => subnet.availability_zone } : { for subnet in aws_subnet.database : subnet.cidr_block => keys(var.database_subnets)[0] } : {}

  route_table_id = aws_route_table.database[each.value].id
  subnet_id      = aws_subnet.database[each.key].id
}

resource "aws_route_table_association" "public" {
  for_each = var.create_vpc && length(var.public_subnets) > 0 ? var.enable_nat_gateway && var.one_nat_gateway_per_az ? { for subnet in aws_subnet.public : subnet.cidr_block => subnet.availability_zone } : { for subnet in aws_subnet.public : subnet.cidr_block => keys(var.public_subnets)[0] } : {}

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public[0].id
}

resource "aws_route_table_association" "middleware" {
  for_each = var.create_vpc && length(var.middleware_subnets) > 0 ? var.enable_nat_gateway && var.one_nat_gateway_per_az ? { for subnet in aws_subnet.middleware : subnet.cidr_block => subnet.availability_zone } : { for subnet in aws_subnet.middleware : subnet.cidr_block => keys(var.middleware_subnets)[0] } : {}

  route_table_id = aws_route_table.middleware[each.value].id
  subnet_id      = aws_subnet.middleware[each.key].id
}
