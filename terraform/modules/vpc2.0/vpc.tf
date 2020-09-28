######
######
# VPC
######
resource "aws_vpc" "this" {
  count = var.create_vpc ? 1 : 0

  cidr_block           = var.cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(
    {
      "Name" = join("-", compact([var.prefix, var.env, "vpc", var.region, local.dependency_identifier["vpc"], local.tag_identifier["vpc"], local.tag_optional["vpc"]]))
    },
    var.tags,
    var.vpc_tags,
  )
}

###################
# DHCP Options Set
###################
resource "aws_vpc_dhcp_options" "this" {
  count = var.create_vpc && var.enable_dhcp_options ? 1 : 0

  domain_name          = var.dhcp_options_domain_name
  domain_name_servers  = var.dhcp_options_domain_name_servers
  ntp_servers          = var.dhcp_options_ntp_servers
  netbios_name_servers = var.dhcp_options_netbios_name_servers
  netbios_node_type    = var.dhcp_options_netbios_node_type

  tags = merge(
    {
      "Name" = join("-", compact([var.prefix, var.env, "dhcp", var.region, local.dependency_identifier["dhcp-options"], local.tag_identifier["dhcp-options"], local.tag_optional["dhcp-options"]]))
    },
    var.tags,
    var.dhcp_options_tags,
  )
}

###############################
# DHCP Options Set Association
###############################
resource "aws_vpc_dhcp_options_association" "this" {
  count = var.create_vpc && var.enable_dhcp_options ? 1 : 0

  vpc_id          = aws_vpc.this[0].id
  dhcp_options_id = aws_vpc_dhcp_options.this[0].id
}

################
# VPC flow logs
################

resource "aws_flow_log" "vpc_flow_log" {
  log_destination = aws_cloudwatch_log_group.vpc_log_group.arn
  iam_role_arn    = aws_iam_role.vpc_flowlogs_role.arn
  vpc_id          = aws_vpc.this[0].id
  traffic_type    = "ALL"
}

resource "aws_cloudwatch_log_group" "vpc_log_group" {
  name = local.vpc_cloudwatch_log_group
  retention_in_days = var.vpc_cloudwatch_log_group_retention
}

resource "aws_iam_role" "vpc_flowlogs_role" {
  name = local.vpc_flowlogs_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

}



resource "aws_iam_role_policy" "vpc_flowlogs_policy" {
  name = local.vpc_flowlogs_policy_name
  role = aws_iam_role.vpc_flowlogs_role.id

  policy = file("${path.module}/${var.policy_path}/${var.vpc_flow_logs_policy_name}")
}
