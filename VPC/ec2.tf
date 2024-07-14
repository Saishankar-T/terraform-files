resource "aws_instance" "test-server1" {
  ami                         = var.instanace_ami
  instance_type               = var.instance_type
  key_name                    = var.instance_key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public-subnet-1.id
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id, aws_security_group.allow_http.id]
  user_data                   = filebase64("sample.sh")
  tags = {
    Name = var.instance_name
  }
}