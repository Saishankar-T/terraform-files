resource "aws_launch_template" "template-1" {
  image_id               = var.template_image_id
  instance_type          = var.template_instance_type
  key_name               = var.template_key_name
  vpc_security_group_ids = [aws_security_group.allow_http.id, aws_security_group.allow_ssh.id]
  user_data              = filebase64("sample.sh")
  tag_specifications {
    resource_type = var.template_resource_type
    tags = {
      Name = var.template_instances_name
    }
  }
  tags = {
    Name = var.template_name
  }
}