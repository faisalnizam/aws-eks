provider "aws" {
  region = var.region
  alias  = "poc-dev"
  assume_role {
    role_arn = local.poc_dev_role
  }
}

provider "aws" {
  region = var.region
}

