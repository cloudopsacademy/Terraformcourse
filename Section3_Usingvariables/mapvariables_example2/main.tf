resource "aws_instance" "firstdemo" {
  ami = var.ami_type[var.region]

  instance_type = var.instance_type[var.env]

  tags = {
    Name = "demoinstance"
  }
}

