variable "region" {
    description = "value of region"
    type = string
    default = "us-east-1"
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

resource "aws_instance" "myserver" {

  ami = "ami-0182f373e66f89c85"
  instance_type = "t3.micro"
  tags = {
    Name = "nitesh"
  }
}