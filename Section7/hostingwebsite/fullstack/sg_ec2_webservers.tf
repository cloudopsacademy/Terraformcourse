resource "aws_security_group" "webservers"
{
  tags
  {
    Name = "${var.PROJECT_NAME}-ec2-webservers"
  }
  name = "${var.PROJECT_NAME}-ec2-webservers"
  description = "Created by Cloudops"
  vpc_id      = "${aws_vpc.main.id}"

  ingress
  {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.SSH_CIDR_WEB_SERVER}"]

  }
  ingress
  {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress{
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress
  {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
