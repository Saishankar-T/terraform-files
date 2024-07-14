terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
  backend "s3" {
    bucket = "terraform-files-237"
    region = "ap-south-1"
    key    = "vpc/vpc"
  }
}
provider "aws" {
  region = var.provider_region
}
resource "aws_vpc" "test-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_name
  }
}



