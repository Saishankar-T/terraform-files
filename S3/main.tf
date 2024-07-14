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
    key    = "s3/s3"
  }
}
provider "aws" {
  region = "ap-south-1"
}
resource "aws_s3_bucket" "bucket-1" {
  bucket = var.bucket_name
  tags = {
    Name = "test"
  }
}
resource "aws_s3_bucket_public_access_block" "a" {
  bucket                  = aws_s3_bucket.bucket-1.id
  block_public_acls       = var.bucket_public_access_acls
  block_public_policy     = var.bucket_public_access_policy
  ignore_public_acls      = true
  restrict_public_buckets = true
}