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
    key    = "alb/alb"
  }
}
provider "aws" {
  region = "ap-south-1"
}
resource "aws_vpc" "test_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "test_vpc"
  }
}
resource "aws_subnet" "pub-subnet-1" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"
  tags = {
    Name = "pub-subnet-1"
  }
}
resource "aws_subnet" "pub-subnet-2" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1b"
  tags = {
    Name = "pub-subnet-2"
  }
}
resource "aws_subnet" "pub-subnet-3" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1c"
  tags = {
    Name = "pub-subnet-3"
  }
}
resource "aws_internet_gateway" "ig-1" {
  vpc_id = aws_vpc.test_vpc.id
  tags = {
    Name = "ig-1"
  }
}
resource "aws_route_table" "pub-rt-1" {
  vpc_id = aws_vpc.test_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig-1.id
  }
  tags = {
    Name = "pub-rt-1"
  }
}
resource "aws_route_table_association" "a" {
  route_table_id = aws_route_table.pub-rt-1.id
  subnet_id      = aws_subnet.pub-subnet-1.id
}
resource "aws_route_table_association" "b" {
  route_table_id = aws_route_table.pub-rt-1.id
  subnet_id      = aws_subnet.pub-subnet-2.id
}
resource "aws_route_table_association" "c" {
  route_table_id = aws_route_table.pub-rt-1.id
  subnet_id      = aws_subnet.pub-subnet-3.id
}
resource "aws_security_group" "allow_ssh" {
  vpc_id = aws_vpc.test_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "allow_ssh"
  }
}
resource "aws_security_group" "allow_http" {
  vpc_id = aws_vpc.test_vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "allow_http"
  }
}
resource "aws_lb_target_group" "tg-1" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.test_vpc.id
  tags = {
    Name = "tg-1"
  }
}
resource "aws_lb" "lb-1" {
  security_groups    = [aws_security_group.allow_http.id]
  load_balancer_type = "application"
  subnets            = [aws_subnet.pub-subnet-1.id, aws_subnet.pub-subnet-2.id, aws_subnet.pub-subnet-3.id]
  tags = {
    Name = "lb-1"
  }
}
resource "aws_lb_listener" "listerner-1" {
  port              = 80
  protocol          = "HTTP"
  load_balancer_arn = aws_lb.lb-1.id
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg-1.id
  }
}
resource "aws_launch_template" "template-1" {
  name                   = "template-1"
  image_id               = "ami-0ad21ae1d0696ad58"
  instance_type          = "t2.micro"
  key_name               = "sai"
  vpc_security_group_ids = [aws_security_group.allow_http.id, aws_security_group.allow_ssh.id]
  user_data              = filebase64("sample.sh")
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "server"
    }
  }
}
resource "aws_autoscaling_group" "asg-1" {
  name                = "asg-1"
  min_size            = 2
  max_size            = 5
  desired_capacity    = 2
  vpc_zone_identifier = [aws_subnet.pub-subnet-1.id, aws_subnet.pub-subnet-2.id]
  launch_template {
    id      = aws_launch_template.template-1.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.tg-1.arn]
}