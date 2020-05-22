resource "aws_instance" "firstdemo" {
  ami = var.amitype

  vpc_security_group_ids = var.sgs

  instance_type = "t2.micro"

  tags = {
    Name = "demoinstance"
  }
}

