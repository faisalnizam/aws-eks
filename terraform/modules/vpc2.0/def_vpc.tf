#########################################
# Remove ingress / egress from default SG
# Remove route through IGW in main RT
#########################################

resource "aws_default_security_group" "default" {
  vpc_id = var.default_vpc_id
}

resource "aws_default_security_group" "this" {
  vpc_id = var.custom_vpc_id
}

resource "aws_default_route_table" "default" {
  default_route_table_id = var.default_vpc_def_rt_id
}

###############################
# VPC flow logs for default VPC
###############################

resource "aws_flow_log" "vpc_flow_log_def" {
  log_destination = aws_cloudwatch_log_group.vpc_log_group_def.arn
  iam_role_arn    = aws_iam_role.vpc_flowlogs_role_def.arn
  vpc_id          = var.default_vpc_id
  traffic_type    = "ALL"
}

resource "aws_cloudwatch_log_group" "vpc_log_group_def" {
  name = local.vpc_def_cloudwatch_log_group
}

resource "aws_iam_role" "vpc_flowlogs_role_def" {
  name = local.vpc_def_flowlogs_role_name

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

resource "aws_iam_role_policy" "vpc_flowlogs_policy_def" {
  name = local.vpc_def_flowlogs_policy_name
  role = aws_iam_role.vpc_flowlogs_role_def.id

  policy = file("${path.module}/${var.policy_path}/${var.vpc_flow_logs_policy_name}")
}
