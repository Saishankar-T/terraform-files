resource "aws_ebs_volume" "ebs_vol-1" {
  availability_zone = var.ebs_volume_az
  size              = var.ebs_volume_size
}

resource "aws_volume_attachment" "a" {
  instance_id = aws_instance.test-server.id
  volume_id   = aws_ebs_volume.ebs_vol-1.id
  device_name = "/dev/sdh"
}