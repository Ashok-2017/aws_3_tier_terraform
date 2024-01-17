resource "aws_autoscaling_policy" "astro_policy_up" {
  name = "astro_policy_up"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 300
  autoscaling_group_name = "${aws_autoscaling_group.web.name}"
}

resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_up" {
  alaram_name = "web_cpu_alarm_up" 
  comparision_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "60"
  statistic = "Average"
  threshold = "80"

  dimensions = {
   AutoScalingGroupName = "${aws_autoscaling_group_name.web.name}"
} 

alarm_description = "This metric monitor EC2 CPU instance utilization"
alarm_actions = ["${aws_autosacling_policy.astro_policy_up.arn}"]

resource "aws_autoscaling_policy" "astro_policy_down" {
   name = "astro_policy_down"
   scaling_adjustment = "-1"
   adjustment_type = "ChangeInCapacity"
   cooldown = "300"
   autoscaling_group_name = "${aws_autoscaling_group.astro_policy_down.arn}"
}

resource "aws_cloudwatch_metric_alarm" "web_cpu_alaram_down" {
  alarm_name = "web_cpu_alaram_down"
  comparision_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "30"
}

dimensions = { 
  AutoScalingGroupName = "${aws_autoscaling_group.web.name}"

}

  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions = [ "${aws_autoscaling_policy.web_policy_down.arn}" ]
}

# aws_autoscaling_policy declares how AWS should change Auto Scaling Group instances count in when aws_cloudwatch_metric_alarm trigger.
# cooldown option will wait for 300 seconds before increasing Auto Scaling Group again.
# aws_cloudwatch_metric_alarm is an alarm, which will be fired, if the total CPU utilization of all instances in our Auto Scaling Group will be the greater or equal threshold value which is 70% during 120 seconds.
# aws_cloudwatch_metric_alarm is an alarm, which also will be fired, if the total CPU utilization of all instances in our Auto Scaling Group will be the lesser or equal threshold value which is 30% during 120 seconds.










