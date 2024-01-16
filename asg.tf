resource "aws_scaling_group" "web" {
  name = "${aws_launch_configuration.web.name}-asg"
  min_size = 1
  desired_capacity = 2
  max_size = 2 

  health_check_type = "ALB"
  load_balancers = [ "${aws_alb.web_alb.id}" ]
  
  launch_configuration = "${aws_launch_configuration.web.name}"

  enabled_metrics 

