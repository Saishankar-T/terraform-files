resource "aws_internet_gateway" "test-ig" {
  vpc_id = aws_vpc.test-vpc.id
  tags = {
    Name = var.ig_name
  }
}