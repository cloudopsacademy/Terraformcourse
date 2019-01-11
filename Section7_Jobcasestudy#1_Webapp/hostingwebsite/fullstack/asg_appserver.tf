resource "aws_autoscaling_group" "appserver" {
  name                      = "appServer "
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 30
  health_check_type         = "EC2"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.for_appserver.name}"
  vpc_zone_identifier       = ["${aws_subnet.private_subnet_1.id}", "${aws_subnet.private_subnet_2.id}"]
  target_group_arns         = ["${aws_lb_target_group.back_end.arn}"]


}
