# AWS Region 변수를 정의합니다.
variable "aws_region" {
  default = "ap-northeast-1"
}

# Auto Scaling Group에서 사용될 EC2 인스턴스 유형을 정의합니다.
 variable "instance_type" {
   default = "t3.micro"
 }

# Hosted zone name, id 정의
variable "zone_name" {
  default = "osmosm.shop"
}
variable "zone_id" {
  default = "Z093279026ZMIZQ76MIQ5"
}
variable "cache_policy_id" {
  default = "658327ea-f89d-4fab-a63d-7e88639e58f6"
}

#DB instace , cluster 생성 시 설정
variable "db_instance_type" {
  description = "DB instance Type"
  type  = string
  default = "db.t3.small"
}

variable "master_username"{
  description = "Username for the master DB user"
  default = "admin"
}

variable "master_password"{
  description = "Password for the master DB user"
  default = "ditn669305"
}

# Tokyo 인증서
# variable "ap-northeast-1_acm"{
#   description = "Tokyo ACM arn"
#   default = "arn:aws:acm:ap-northeast-1:417574981094:certificate/135fc005-95e9-4f87-a18e-ecb05bc4f624"
# }


#Jenkins에서 변수로 받아온 Key
variable "AWS_ACCESS_KEY_ID" {
  type        = string
  description = "AWS access key"
}
variable"AWS_SECRET_ACCESS_KEY"{
  type      = string
  description = "AWS secret key"
}




