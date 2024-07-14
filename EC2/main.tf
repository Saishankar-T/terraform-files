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
    key    = "ec2/ec2"
  }
}
provider "aws" {
  region = var.provider_region
}
resource "aws_instance" "test-server" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = var.instance_key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id, aws_security_group.allow_http.id, aws_security_group.allow_https.id]
  user_data              = filebase64("sample.sh")
  tags = {
    Name = var.instance_name
  }
  root_block_device {
    volume_size = var.root_volume_size
  }
}