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
    key    = "lb/lb"
  }
}
provider "aws" {
  region = var.provider_region
}

resource "aws_lb" "lb-1" {
  security_groups    = [aws_security_group.allow_http.id]
  load_balancer_type = var.lb_type
  subnets            = [aws_instance.server-1.subnet_id, aws_instance.server-2.subnet_id]
  tags = {
    Name = var.lb_name
  }
}
resource "aws_lb_listener" "listner-1" {
  port              = 80
  protocol          = "HTTP"
  load_balancer_arn = aws_lb.lb-1.id

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg-1.id
  }
}
