resource "aws_cloudwatch_metric_alarm" "tfer--AutoScaling-0020-Out-0020-alram" {
  #actions_enabled     = "true"
  alarm_actions       = ["arn:aws:autoscaling:us-west-2:687365294585:scalingPolicy:43fa689f-8db0-4327-865c-a4c01a91644f:autoScalingGroupName/test:policyName/Step_Scaling", "arn:aws:sns:us-west-2:687365294585:Test-AS-SNS-01"]
  #alarm_name          = "AutoScaling Out alram"
  #comparison_operator = "GreaterThanOrEqualToThreshold"
  #datapoints_to_alarm = "1"

  dimensions = {
    AutoScalingGroupName = "EC2_Autoscaling"
  }

  evaluation_periods = "1"
  metric_name        = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = "300"
  statistic          = "Average"
  threshold          = "70"         # 임계값
  
}
