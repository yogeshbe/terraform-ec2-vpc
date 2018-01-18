/**
 * Application LoadBalancer
 */
resource "aws_alb" "front" {
  name            = "wpapp"
  internal        = false
  security_groups = ["${aws_security_group.web.id}"]
  subnets         =  ["${aws_subnet.us-east-1a-public.id}","${aws_subnet.us-east-2c-public.id}"]


  enable_deletion_protection = false

 
  tags {
    
    Environment = "Developmet"
  }
}

/**
 * Target group for ALB
 */
resource "aws_alb_target_group" "web" {
  name     = "dev-web"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.yogesh-demo.id}"

  stickiness {
    type = "lb_cookie"
  }

  health_check {
    path = "/"
  }

  tags {
  
    Environment = "Development"
  }
}

/**
 * HTTP Lister for ALB
 */
resource "aws_alb_listener" "front_80" {
   load_balancer_arn = "${aws_alb.front.arn}"
   port = "80"
   protocol = "HTTP"
   default_action {
     target_group_arn = "${aws_alb_target_group.web.arn}"
     type = "forward"
   }
}
resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = "${aws_autoscaling_group.agents.id}"
  alb_target_group_arn   = "${aws_alb_target_group.web.arn}"
}

