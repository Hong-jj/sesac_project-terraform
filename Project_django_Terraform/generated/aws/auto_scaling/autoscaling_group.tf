resource "aws_autoscaling_group" "tfer--test" {
  availability_zones        = ["us-west-2a"]
  capacity_rebalance        = "false"
  default_cooldown          = "300"
  default_instance_warmup   = "0"
  desired_capacity          = "1"
  enabled_metrics           = ["GroupAndWarmPoolDesiredCapacity", "GroupAndWarmPoolTotalCapacity", "GroupDesiredCapacity", "GroupInServiceCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingCapacity", "GroupPendingInstances", "GroupStandbyCapacity", "GroupStandbyInstances", "GroupTerminatingCapacity", "GroupTerminatingInstances", "GroupTotalCapacity", "GroupTotalInstances", "WarmPoolDesiredCapacity", "WarmPoolMinSize", "WarmPoolPendingCapacity", "WarmPoolTerminatingCapacity", "WarmPoolTotalCapacity", "WarmPoolWarmedCapacity"]
  force_delete              = "false"
  health_check_grace_period = "300"
  health_check_type         = "ELB"

  launch_template {
    id      = "lt-029bb45b915c7a24e"
    name    = "Tem-ver0.1"
    version = "$Default"
  }

  max_instance_lifetime   = "0"
  max_size                = "3"
  metrics_granularity     = "1Minute"
  min_size                = "1"
  name                    = "test"
  protect_from_scale_in   = "false"
  service_linked_role_arn = "arn:aws:iam::687365294585:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"

  tag {
    key                 = "Name"
    propagate_at_launch = "true"
    value               = "Test-ag"
  }

  target_group_arns         = ["arn:aws:elasticloadbalancing:us-west-2:687365294585:targetgroup/Test-TG-HTTP/09f6259c59f3f443"]
  vpc_zone_identifier       = ["subnet-07bc24f4007eb3004", "subnet-0dd9a1b992d8b94ff"]
  wait_for_capacity_timeout = "10m"
}
