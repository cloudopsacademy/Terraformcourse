resource "aws_instance" "firstdemo" {
  count = 3

  ami = "ami-922914f7"

  instance_type = "t2.micro"

  tags = {
    Name = "threedemoinstance-${count.index}"
  }
}

