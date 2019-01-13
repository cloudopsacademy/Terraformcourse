
module "elb_http" {

source = "github.com/terraform-aws-modules/terraform-aws-elb.git"

name = "elb1"

internal = "false"

subnets = ["subnet-a4a922cc", "subnet-8dcf0cf7"]

security_groups = ["sg-07b2fc6c"]

listener = [

{

instance_port = "80"

instance_protocol = "HTTP"

lb_port = "80"

lb_protocol = "HTTP"

},

]

health_check = [

{

target = "HTTP:80/"

interval = 30

healthy_threshold = 2

unhealthy_threshold = 2

timeout = 5

},

]

}




