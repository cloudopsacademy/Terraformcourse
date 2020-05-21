variable "amitype" {
  default = "ami-922914f7"
}

variable "sgs" {
  type = list(string)

  default = ["sg-07b2fc6c", "sg-48bba323"]
}

