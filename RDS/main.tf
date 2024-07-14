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
    key    = "rds/rds"
  }
}
provider "aws" {
  region = var.provider_region
}
resource "aws_db_instance" "test-db" {
  engine                 = var.db-engine
  engine_version         = var.db-engine_version
  instance_class         = var.db-instance_class
  allocated_storage      = var.db-allocated_storage
  db_name                = var.db-name
  username               = var.db-username
  password               = var.db-password
  skip_final_snapshot    = var.skip_final_snapshot
  deletion_protection    = var.deletion_protection
  publicly_accessible    = var.publicly_accessible
  vpc_security_group_ids = [aws_security_group.allow_port-3306.id]
  tags = {
    Name = "test-db"
  }
  identifier = var.identifier-name
}