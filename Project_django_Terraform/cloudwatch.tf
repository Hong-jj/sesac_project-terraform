# Cloudwatch Alarm metric 생성
resource "aws_cloudwatch_metric_alarm" "Django_metric_alarm"{
    alarm_description   = "This metric monitors ec2 cpu utilization"
    alarm_name          = "cpu_alarm"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    #트리거 하기위해 위반해야하는 포인트 수
    datapoints_to_alarm = "1"
    evaluation_periods = "2"
    metric_name =   "CPUUtilization"
    namespace   =   "AWS/EC2"
    period             = "300"
    statistic          = "Average"
    threshold          = "60"   #임계값

    dimensions ={
        autoScalingGroupName = "EC2_Autoscaling"
    }
    
   # Auto Scaling Poliy는 Gui or instance에 agent를 설치해 copy해서 사용
    
}