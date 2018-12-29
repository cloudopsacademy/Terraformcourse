resource "aws_instance" "firstdemo" {

ami = "${var.amitype}"

security_groups = "${var.sgs}"

instance_type = "t2.micro"


tags {

Name = "demoinstance"

}

}






