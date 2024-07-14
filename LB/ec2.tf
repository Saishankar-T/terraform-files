resource "aws_instance" "server-1" {
  ami                    = "ami-0ad21ae1d0696ad58"
  instance_type          = "t2.micro"
  key_name               = "sai"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id, aws_security_group.allow_http.id]
  availability_zone      = "ap-south-1a"
  user_data              = filebase64("sample.sh")

  tags = {
    Name = "server-1"
  }
}
resource "aws_instance" "server-2" {
  ami                    = "ami-0ad21ae1d0696ad58"
  instance_type          = "t2.micro"
  key_name               = "sai"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id, aws_security_group.allow_http.id]
  availability_zone      = "ap-south-1b"
  user_data              = filebase64("sample.sh")

  tags = {
    Name = "server-2"
  }
}