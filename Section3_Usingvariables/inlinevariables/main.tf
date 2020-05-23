resource "aws_instance" "firstdemo" {
  ami           = var.amitype
  instance_type = "t2.micro"

  tags = {
    Name = "demoinstance"
  }
}

