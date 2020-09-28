locals {
  reversed_private_networks      = transpose(var.private_subnets)
  reserved_loadbalancer_networks = transpose(var.loadbalancer_subnets)
  reversed_database_networks     = transpose(var.database_subnets)
  reversed_public_networks       = transpose(var.public_subnets)
  reserved_middleware_networks   = transpose(var.middleware_subnets)


  dependency_identifier = {
    "sn-public"         = ""
    "sn-private"        = ""
    "sn-loadbalance"    = ""
    "sn-database"       = ""
    "sn-middleware"     = ""
    "rt-private"        = ""
    "rt-loadbalance"    = ""
    "rt-database"       = ""
    "rt-public"         = ""
    "rt-middleware"     = ""
    "igw"               = ""
    "natgw"             = ""
    "eipnat"            = ""
    "vpc"               = ""
    "dhcp-options"      = ""
    "sn-group-database" = ""
  }

  tag_identifier = {
    "sn-public"         = "public"
    "sn-private"        = "private"
    "sn-loadbalance"    = "loadbalancer"
    "sn-database"       = "database"
    "sn-middleware"     = "middleware"
    "rt-private"        = "private"
    "rt-loadbalance"    = "loadbalance"
    "rt-database"       = "database"
    "rt-public"         = "public"
    "rt-middleware"     = "middleware"
    "igw"               = ""
    "natgw"             = ""
    "eipnat"            = ""
    "vpc"               = ""
    "dhcp-options"      = ""
    "sn-group-database" = "database"
  }

  tag_optional = {
    "sn-public"         = ""
    "sn-private"        = ""
    "sn-loadbalance"    = ""
    "sn-database"       = ""
    "sn-middleware"     = ""
    "rt-private"        = ""
    "rt-loadbalance"    = ""
    "rt-database"       = ""
    "rt-public"         = ""
    "rt-middleware"     = ""
    "igw"               = ""
    "natgw"             = ""
    "eipnat"            = ""
    "vpc"               = ""
    "dhcp-options"      = ""
    "sn-group-database" = ""
    "tgw_tags"          = ""
  }

  ### Logging details

  vpc_flowlogs_role_name       = join("-", compact([var.prefix, var.env, "iam", var.region, "vpc", "flowlogs-role"]))
  vpc_flowlogs_policy_name     = join("-", compact([var.prefix, var.env, "iam", var.region, "vpc", "flowlogs-policy"]))
  vpc_cloudwatch_log_group     = join("-", compact([var.prefix, var.env, "cw", var.region, "vpc", "flowlogs-log-group"]))
  vpc_def_flowlogs_role_name   = join("-", compact([var.prefix, var.env, "iam", var.region, "vpc", "default-flowlogs-role"]))
  vpc_def_flowlogs_policy_name = join("-", compact([var.prefix, var.env, "iam", var.region, "vpc", "default-flowlogs-policy"]))
  vpc_def_cloudwatch_log_group = join("-", compact([var.prefix, var.env, "cw", var.region, "vpc", "default-flowlogs-log-group"]))
}
