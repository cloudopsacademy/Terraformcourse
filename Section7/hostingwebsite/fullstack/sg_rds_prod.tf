resource "aws_security_group" "rds-prod"
{
  tags{
    Name = "${var.PROJECT_NAME}-rds-production"
  }
  name = "${var.PROJECT_NAME}-rds-production"
  description = "Created by Cloudops"
  vpc_id      = "${aws_vpc.main.id}"
  ingress
  {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["${var.RDS_CIDR}"]

  }

  ingress
  {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = ["${aws_security_group.appservers.id}"]

  }
  egress
  {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
