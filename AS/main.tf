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
    key    = "as/as"
  }
}
provider "aws" {
  region = var.provider_region
}
resource "aws_autoscaling_group" "asg-1" {
  name               = var.asg_name
  min_size           = var.asg_min_size
  max_size           = var.asg_max_size
  desired_capacity   = var.asg_desired_capacity
  availability_zones = var.asg_az
  launch_template {
    id      = aws_launch_template.template-1.id
    version = "$Latest"
  }
}