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
    key    = "ecr/ecr"
  }
}
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"

}
resource "aws_ecr_repository" "test" {
  name                 = var.private_repository_name
  image_tag_mutability = var.image_tag_mutability
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
  tags = {
    Name = "test-repo-private"
  }
}
resource "aws_ecrpublic_repository" "test-pub" {
  repository_name = var.public_repository_name
  provider        = aws.us_east_1
  tags = {
    Name = "test-repo-pub"
  }
}