resource "aws_scaling_group" "web" {
  name = "${aws_launch_configuration.web.name}-asg"
  min_size = 1
  desired_capacity = 2
  max_size = 2 

  health_check_type = "ALB"
  load_balancers = [ "${aws_alb.web_alb.id}" ]
  
  launch_configuration = "${aws_launch_configuration.web.name}"

  enabled_metrics = [ 
    "GroupMinSize", 
    "GroupMaxSize", 
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
]
metrics_granualarity = "1Minute"
vpc_zone_identifier = [ 
 "${aws_subnet.astrosubnet.id}", 
 "${aws_subnet.astrosubnet1.id}" 
]
# Required to redeploy with out an outage
lifecycle {
  create_before_destroy = true 
}
tag {
   key = "Name"
   value = "web"
   propogate_at_launch = true
  }
} 

# There will be a minimum of 1 instance to serve the traffic.
# There will be at max 2 instancess to serve the traffic.
# Auto Scaling Group will be launched with 1instance
# Auto Scaling Group will get information about instance availability from the ELB
# I have set up a collection for some Cloud Watch metrics to monitor the Auto Scaling Group state.
# Each instance launched from this Auto Scaling Group will have Name a tag set to web.















