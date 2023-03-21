#Create sns_topic
resource "aws_sns_topic" "Autoscaling_updates"{
    name = "instance-scailout-topic"

    tags={
        Name = "AutoScaling-topic"
    }
}

# SNS 구독
resource "aws_sns_topic_subscription" "Autoscaling_updates_target"{
    topic_arn = aws_sns_topic.Autoscaling_updates.arn
    protocol = "email"
    endpoint = "tjdalsd66@naver.com"
}

#AutoScaling에 따른 SNS 메일 설정
resource "aws_autoscaling_notification" "event_mail"{
  group_names = [
    aws_autoscaling_group.Django_autoscaling_group.name,
  ]

  notifications =[
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = aws_sns_topic.Autoscaling_updates.arn
}




