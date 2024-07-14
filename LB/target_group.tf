resource "aws_lb_target_group" "tg-1" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  tags = {
    Name = var.tg_name
  }
}
resource "aws_lb_target_group_attachment" "a" {
  target_group_arn = aws_lb_target_group.tg-1.id
  target_id        = aws_instance.server-1.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "b" {
  target_group_arn = aws_lb_target_group.tg-1.id
  target_id        = aws_instance.server-2.id
  port             = 80
}