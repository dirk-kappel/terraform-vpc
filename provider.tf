terraform {
  required_version = "~> 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region_1
  profile = var.aws_profile
  default_tags {
    tags = {
      Terraform = "true"
    }
  }
}

# provider "aws" {
#   alias   = "west_2"
#   region  = var.aws_region_2
#   profile = var.aws_profile
#   default_tags {
#     tags = {
#       Terraform = "true"
#     }
#   }
# }