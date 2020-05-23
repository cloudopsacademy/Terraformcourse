variable "amitype" {
  default = "ami-922914f7"
}

variable "env" {
}

variable "region" {
  default = "us-east-2"
}

variable "instance_type" {
  type = map(string)

  default = {
    dev  = "t2.micro"
    test = "t2.medium"
  }
}

