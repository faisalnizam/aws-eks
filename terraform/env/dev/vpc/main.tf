
data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

module "vpc" {
  source = "../../../modules/vpc/"

  name = "poc-vpc"

  cidr = "20.10.0.0/16" 

  azs                 = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets     = ["20.10.1.0/24", "20.10.2.0/24", "20.10.3.0/24"]
  public_subnets      = ["20.10.11.0/24", "20.10.12.0/24", "20.10.13.0/24"]
  database_subnets    = ["20.10.21.0/24", "20.10.22.0/24", "20.10.23.0/24"]
  intra_subnets       = ["20.10.51.0/24", "20.10.52.0/24", "20.10.53.0/24"]

  create_database_subnet_group = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_classiclink             = true
  enable_classiclink_dns_support = true

  enable_nat_gateway = true
  single_nat_gateway = true


  enable_vpn_gateway = false

  enable_dhcp_options              = true
  dhcp_options_domain_name         = "poc.example"
  dhcp_options_domain_name_servers = ["127.0.0.1", "10.10.0.2"]

  # VPC endpoint for SSM
  enable_ssm_endpoint              = true
  ssm_endpoint_private_dns_enabled = true
  ssm_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  # VPC endpoint for SSMMESSAGES
  enable_ssmmessages_endpoint              = true
  ssmmessages_endpoint_private_dns_enabled = true
  ssmmessages_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  # Default security group - ingress/egress rules cleared to deny all
  manage_default_security_group  = true
  default_security_group_ingress = [{}]
  default_security_group_egress  = [{}]

  tags = {
    Owner       = "faisal"
    Environment = "DEV"
    Name        = "VPC"
  }

  vpc_endpoint_tags = {
    Project  = "POC"
    Endpoint = "true"
  }
}

