resource "aws_instance" "firstdemo" {

ami = "${var.amitype}"

instance_type="${lookup(var.instance_type,var.env)}"

tags {

    Name = "demoinstance"

   }

}


