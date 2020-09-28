##################
# Private subnet #
##################
resource "aws_subnet" "private" {
  for_each = var.create_vpc && length(var.private_subnets) > 0 ? local.reversed_private_networks : null
  vpc_id   = aws_vpc.this[0].id

  availability_zone = element(each.value, 0)
  cidr_block        = each.key


  tags = merge(
    {
      "Name" = join("-", compact([var.prefix, var.env, "sub", var.region, local.dependency_identifier["sn-private"], local.tag_identifier["sn-private"], local.tag_optional["sn-private"], element(split("-", element(each.value, 0)), 2)]))
    },
    var.tags,
    var.private_subnet_tags,
  )
}

#######################
# Loadbalancer subnet #
#######################

resource "aws_subnet" "pri_loadbalancer" {
  for_each = var.create_vpc && length(var.loadbalancer_subnets) > 0 ? local.reserved_loadbalancer_networks : null
  vpc_id     = aws_vpc.this[0].id

  availability_zone = element(each.value, 0)
  cidr_block = each.key

  tags = merge(
    {
      "Name" = join("-", compact([var.prefix, var.env, "sub", var.region, local.dependency_identifier["sn-loadbalance"], local.tag_identifier["sn-loadbalance"], local.tag_optional["sn-loadbalance"], element(split("-", element(each.value, 0)), 2)]))
    },
    var.tags,
    var.loadbalancer_subnet_tags,
  )

}

###################
# Database subnet #
###################
resource "aws_subnet" "database" {
  for_each = var.create_vpc && length(var.database_subnets) > 0 ? local.reversed_database_networks : null
  vpc_id   = aws_vpc.this[0].id

  availability_zone = element(each.value, 0)
  cidr_block        = each.key


  tags = merge(
    {
      "Name" = join("-", compact([var.prefix, var.env, "sub", var.region, local.dependency_identifier["sn-database"], local.tag_identifier["sn-database"], local.tag_optional["sn-database"], element(split("-", element(each.value, 0)), 2)]))
    },
    var.tags,
    var.database_subnet_tags,
  )
}

#####################
# Middleware subnet #
#####################

resource "aws_subnet" "middleware" {
  for_each = var.create_vpc && length(var.middleware_subnets) > 0 ? local.reserved_middleware_networks : null
  vpc_id     = aws_vpc.this[0].id

  availability_zone = element(each.value, 0)
  cidr_block = each.key

  tags = merge(
    {
      "Name" = join("-", compact([var.prefix, var.env, "sub", var.region, local.dependency_identifier["sn-middleware"], local.tag_identifier["sn-middleware"], local.tag_optional["sn-middleware"], element(split("-", element(each.value, 0)), 2)]))
    },
    var.tags,
    var.middleware_subnet_tags,
  )

}

#################
# Public subnet #
#################
resource "aws_subnet" "public" {
  for_each = var.create_vpc && length(var.public_subnets) > 0 ? local.reversed_public_networks : null

  vpc_id                  = aws_vpc.this[0].id
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = element(each.value, 0)
  cidr_block              = each.key

  tags = merge(
    {
      "Name" = join("-", compact([var.prefix, var.env, "sub", var.region, local.dependency_identifier["sn-public"], local.tag_identifier["sn-public"], local.tag_optional["sn-public"], element(split("-", element(each.value, 0)), 2)]))
    },
    var.tags,
    var.public_subnet_tags,
  )
}


resource "aws_db_subnet_group" "database" {
  count = var.create_vpc && length(var.database_subnets) > 0 && var.create_database_subnet_group ? 1 : 0

  name        = join("-", compact([var.prefix, var.env, "sn-group", var.region, local.dependency_identifier["sn-group-database"], local.tag_identifier["sn-group-database"], local.tag_optional["sn-group-database"]]))
  description = "Database subnet group for ${var.env}"
  subnet_ids  = [for subnet in aws_subnet.database : subnet.id]

  tags = merge(
    {
      "Name" = join("-", compact([var.prefix, var.env, "sn-group", var.region, local.dependency_identifier["sn-group-database"], local.tag_identifier["sn-group-database"], local.tag_optional["sn-group-database"]]))
    },
    var.tags,
    var.database_subnet_group_tags,
  )
}
