variable "env" {
}

variable "region" {
  default = "us-east-2"
}

variable "ami_type" {
  default = {
    type      = "map"
    us-east-1 = "ami-14c5486b"
    us-east-2 = "ami-922914f7"
  }
}

variable "instance_type" {
  type = map(string)

  default = {
    dev  = "t2.micro"
    test = "t2.medium"
  }
}

