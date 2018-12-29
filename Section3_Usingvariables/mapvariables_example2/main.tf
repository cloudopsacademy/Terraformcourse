resource "aws_instance" "firstdemo" {

ami = "${lookup(var.ami_type,var.region)}"

instance_type="${lookup(var.instance_type,var.env)}"

tags {

    Name = "demoinstance"

   }

}


