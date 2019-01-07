#Application load balancer for app server
resource "aws_lb" "back_end" {
  name               = "${var.PROJECT_NAME}-Back-End-ALB"
  internal           = true
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.appservers_alb.id}"]
  subnets            = ["${aws_subnet.private_subnet_2.id}","${aws_subnet.private_subnet_1.id}"]

}

# Adding HTTP listener

resource "aws_lb_listener" "appserver" {
  load_balancer_arn = "${aws_lb.back_end.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.back_end.arn}"
    type             = "forward"
  }
}

# Add Target Group

resource "aws_lb_target_group" "back_end" {
  name     = "Target-Group-for-backend"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.main.id}"
}

output "Application Load Balancer Endpoint" {
  value = "${aws_lb.back_end.dns_name}"
}
