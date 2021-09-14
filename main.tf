provider "aws" {
    region = "eu-west-3"
    access_key = "AKIAWFPH4OZECWBOVF6K"
    secret_key = "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"
}

variable "subnet_cidr_block" {
    description = "subnet cidr block"
    type = list(string)
}

variable "vpc_cidr_block" {
    description = "vpc cidr block"
}

variable "environment" {
    description = "environment name"
}
resource "aws_vpc" "development-vpc" {
    cidr_block = var.subnet_cidr_block[0]
    tags = {
        Name: var.environment
        vpc_env: "dev"
    }
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = var.subnet_cidr_block[1]
    availability_zone = "eu-west-3a"
    tags = {
      Name: "subnet-1-dev"
    }
}

data "aws_vpc" "existing-vpc"{
    default = true    
}

resource "aws_subnet" "dev-subnet-2" {
    vpc_id = data.aws_vpc.existing-vpc.id
    cidr_block = "172.31.48.0/20"
    availability_zone = "eu-west-3a"
    tags = {
      Name: "subnet-2-default"
    }    
}

output "dev-vpc-id" {
  value = aws_vpc.development-vpc.id
}

output "dev-subnet-id" {
  value = aws_subnet.dev-subnet-1.id
}