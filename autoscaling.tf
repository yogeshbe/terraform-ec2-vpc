resource "aws_launch_configuration" "agent-lc" {
    name_prefix = "agent-lc-"
    image_id = "ami-82f4dae7"
    security_groups=["${aws_security_group.web.id}"]
    instance_type = "t2.micro"
    key_name="yogeshb"
    associate_public_ip_address = true
   # user_data =  "${data.template_file.userdata.rendered}"
    user_data = "${data.template_file.sample.rendered}"
            
 
    lifecycle {

        create_before_destroy = true
    }
 

#depends_on = ["{aws_security_group.web"]


 }
data  "template_file" "sample" {
  template = "${file("userdata.tpl")}"

  vars = {
    value = "hello world"
   # script = "${file("userdata.sh")}"
  }
}
/*
data "template_file" "userdata" {
    template = "userdata.tpl"
     vars {
      #  dbhost = "${aws_db_instance.wpdb.address}"
  }


#depends_on = ["{aws_db_instance.wpdb"]
}*/

#Auto Scalling
resource "aws_autoscaling_group" "agents" {
    vpc_zone_identifier = ["${aws_subnet.us-east-1a-public.id}","${aws_subnet.us-east-2c-public.id}"]
    #availability_zones = ["us-east-2b"]
    name = "agents"
    max_size = "3"
    min_size = "1"
    health_check_grace_period = 300
    health_check_type = "EC2"
    desired_capacity = 2
    #load_balancers            = [ "${aws_alb.front.id}" ]	
    force_delete = true
    launch_configuration = "${aws_launch_configuration.agent-lc.name}"

    tag {
        key = "Name"
        value = "Agent Instance"
        propagate_at_launch = true
    }
depends_on = ["aws_launch_configuration.agent-lc"]
} 

resource "aws_autoscaling_policy" "agents-scale-up" {
    name = "agents-scale-up"
    scaling_adjustment = 1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = "${aws_autoscaling_group.agents.name}"
}

resource "aws_autoscaling_policy" "agents-scale-down" {
    name = "agents-scale-down"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = "${aws_autoscaling_group.agents.name}"
}

