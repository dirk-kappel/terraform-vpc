variable "aws_region_1" {
  type    = string
  default = "us-east-1"
}

# variable "aws_region_2" {
#   type    = string
#   default = "us-west-2"
# }

variable "aws_profile" {
  type    = string
  default = "dirk-wwt"
}

variable "firewall" {
  default = {
    cidr_block = "10.55.10.0/24"
    subnets = {
      firewall-external-subnet-a = {
        cidr_block        = "10.55.10.0/27"
        availability_zone = "us-east-1a"
      },
      firewall-management-subnet-a = {
        cidr_block        = "10.55.10.32/27"
        availability_zone = "us-east-1a"
      },
      firewall-internal-subnet-a = {
        cidr_block        = "10.55.10.64/27"
        availability_zone = "us-east-1a"
      },
      firewall-tgw-attach-subnet-a = {
        cidr_block        = "10.55.10.192/28"
        availability_zone = "us-east-1a"
      },
      firewall-external-subnet-b = {
        cidr_block        = "10.55.10.96/27"
        availability_zone = "us-east-1b"
      },
      firewall-management-subnet-b = {
        cidr_block        = "10.55.10.128/27"
        availability_zone = "us-east-1b"
      },
      firewall-internal-subnet-b = {
        cidr_block        = "10.55.10.160/27"
        availability_zone = "us-east-1b"
      },
      firewall-tgw-attach-subnet-b = {
        cidr_block        = "10.55.10.208/28"
        availability_zone = "us-east-1b"
      }

    },
    tags = {
      Name = "Firewall-VPC"
    }
  }
}

variable "production" {
  default = {
    cidr_block = "10.55.0.0/22"
    subnets = {
      Data-subnet-A = {
        cidr_block        = "10.55.0.0/24"
        availability_zone = "us-east-1a"
      },
      Web-App-Subnet-A = {
        cidr_block        = "10.55.3.0/26"
        availability_zone = "us-east-1a"
      },
      TGW-Subnet-A = {
        cidr_block        = "10.55.3.192/28"
        availability_zone = "us-east-1a"
      }
    },
    tags = {
      Name = "Production-VPC"
    }
  }
}

variable "onprem" {
  default = {
    cidr_block = "10.0.0.0/16"
    subnets = {
      Gateway = {
        cidr_block        = "10.0.0.0/24"
        availability_zone = "us-east-1a"
      },
      test-machine = {
        cidr_block        = "10.0.1.0/24"
        availability_zone = "us-east-1a"
      }
    },
    tags = {
      Name = "On-Prem"
    }
  }
}