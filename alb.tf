# Creating an External Load balancer

resource "aws_lb" "external-alb" {
  name = "External lb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.astrosg.id]
  subnets = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]
}

resource "aws_lb_target_group" "target-elb" {
  name = "ALB TG"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.astrovpc.id
}

resource "aws_lb_target_group_attachment" "attachment" {
  target_group_arn = aws_lb_target_group.external-alb.arn
  target_id = aws_instance.astroinstance.id
  port = 80

depends_on = [
  aws_instance.astroinstance, 
]
}

resource "aws_lb_listener" "external-alb" {
  load_balacer_arn = aws_lb.external-alb.arn
  port = "80"
  protocol = "http"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.external-alb.arn
}
}

cross_zone_load_balancing = true
health_check { 
  healthy_threshold = 2 
  unhealthy_threshold = 2 
  timeout = 3
  interval = 30
  target = "HTTP:80/"
}

listener {
  lb_port = 80
  lb_protocol = "http"
  instance_port = "80"
  instance_protocol = "http"
}













#The above load balancer is of type external
#Load balancer type is set to application
#The aws_lb_target_group_attachment resource will attach our instances to the Target Group.
#The load balancer will listen requests on port 80
















   
