resource "aws_instance" "firstdemo" {
  ami = var.amitype

  instance_type = var.instance_type[var.env]

  tags = {
    Name = "demoinstance"
  }
}

