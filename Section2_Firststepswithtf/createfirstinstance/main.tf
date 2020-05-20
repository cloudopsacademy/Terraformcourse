resource "aws_instance" "firstdemo" {
  ami = "ami-922914f7"

  instance_type = "t2.micro"

  tags = {
    Name = "demoinstance"
  }
}

