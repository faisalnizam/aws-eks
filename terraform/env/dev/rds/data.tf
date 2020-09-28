// DB
data "aws_subnet" "isapi-dev-sub-me-south-1-database-1a" {
  provider = aws.isapi-dev
  tags     = { Name = "isapi-dev-sub-me-south-1-database-1a" }
}

data "aws_subnet" "isapi-dev-sub-me-south-1-database-1b" {
  provider = aws.isapi-dev
  tags     = { Name = "isapi-dev-sub-me-south-1-database-1b" }
}

// LB
data "aws_subnet" "isapi-dev-sub-me-south-1-loadbalancer-1a" {
  provider = aws.isapi-dev
  tags     = { Name = "isapi-dev-sub-me-south-1-loadbalancer-1a" }
}

data "aws_subnet" "isapi-dev-sub-me-south-1-loadbalancer-1b" {
  provider = aws.isapi-dev
  tags     = { Name = "isapi-dev-sub-me-south-1-loadbalancer-1b" }
}

data "aws_subnet_ids" "all_lb" {
  vpc_id   = data.aws_vpc.isapi-dev-vpc-me-south-1.id
  provider = aws.isapi-dev
  filter {
    name   = "tag:Name"
    values = ["*loadbalancer*"]
  }
}

// Private
data "aws_subnet" "isapi-dev-sub-me-south-1-private-1a" {
  provider = aws.isapi-dev
  tags     = { Name = "isapi-dev-sub-me-south-1-private-1a" }
}

data "aws_subnet" "isapi-dev-sub-me-south-1-private-1b" {
  provider = aws.isapi-dev
  tags     = { Name = "isapi-dev-sub-me-south-1-private-1b" }
}

//VPC
data "aws_vpc" "isapi-dev-vpc-me-south-1" {
  provider = aws.isapi-dev
  default  = false
  id       = "vpc-0730436ed39e7183e"
}

// images
data "aws_ami" "windows" {
  provider = aws.isapi-dev
  filter {
    name   = "name"
    values = ["EXPO2020_W2K16_DC_Sysprep_Golden_Image_v1.0_not_encrypted"]
  }
  owners = ["865392845814"]
}

data "aws_ami" "ubuntu" {
  provider = aws.isapi-dev
  filter {
    name   = "name"
    values = ["AMI-EXPO-Ubuntu-LTS-18.04-Golden_Image-11122019-1210_not_encrypted"]
  }
  owners = ["865392845814"]
}
