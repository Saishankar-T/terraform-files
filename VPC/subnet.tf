resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.test-vpc.id
  cidr_block              = var.subnet-1_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.subnet-1-az
  tags = {
    Name = var.subnet-1_name
  }
}
resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.test-vpc.id
  cidr_block              = var.subnet-2_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.subnet-2-az
  tags = {
    Name = var.subnet-2_name
  }
}
resource "aws_subnet" "public-subnet-3" {
  vpc_id                  = aws_vpc.test-vpc.id
  cidr_block              = var.subnet-3_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.subnet-3-az
  tags = {
    Name = var.subnet-3_name
  }
}