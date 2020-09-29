// DB
data "aws_subnet" "poc-dev-sub-me-south-1-database-1a" {
  provider = aws.poc-dev
  tags     = { Name = "poc-dev-sub-me-south-1-database-1a" }
}

data "aws_subnet" "poc-dev-sub-me-south-1-database-1b" {
  provider = aws.poc-dev
  tags     = { Name = "poc-dev-sub-me-south-1-database-1b" }
}

data "aws_subnet_ids" "all_db" {
  vpc_id   = data.aws_vpc.poc-dev-vpc-me-south-1.id
  provider = aws.poc-dev
  filter {
    name   = "tag:Name"
    values = ["*database_subnets*"]
  }
}

//VPC
data "aws_vpc" "poc-dev-vpc-me-south-1" {
  provider = aws.poc-dev
  default  = false
  id       = "vpc-0730436ed39e7183e"
}
