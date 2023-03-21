# 현재 프로젝트(backup region)는 Route53을 Terraform으로 사용하지 않음(수정X)
# resource "aws_route53_record" "www_aws" {
#   zone_id         = var.zone_id
#   name            = "www.${var.zone_name}"
#   type            = "A"
#   health_check_id = "0b289f47-057d-4649-815a-dcdd66735cdb"
#   weighted_routing_policy {
#     weight = 50
#   }
#     set_identifier = "aws"
#   # CloudFront 배포의 도메인 이름과 호스팅 영역 ID
#   alias {
#     name    = aws_cloudfront_distribution.web_distribution.domain_name
#     zone_id = aws_cloudfront_distribution.web_distribution.hosted_zone_id
#     evaluate_target_health = false
#   }
# }

# resource "aws_route53_health_check" "www_aws_hc" {
#   fqdn              = aws_cloudfront_distribution.web_distribution.domain_name
#   port              = 80
#   type              = "HTTP"
#   resource_path     = "/"
#   failure_threshold = "5"
#   request_interval  = "30"

#   tags = {
#     Name = "aws-health-check"
#   }
# }

# # IDC 부분 잘 안됨
# resource "aws_route53_record" "www_idc" {
#   zone_id         = var.zone_id
#   name            = "www.${var.zone_name}"
#   type            = "A"
#   records         = ["111.67.218.43"]
#   health_check_id = "0b289f47-057d-4649-815a-dcdd66735cdb"

#   weighted_routing_policy {
#     weight = 50
#   }
#       set_identifier = "idc"
# }

# resource "aws_route53_health_check" "www_idc_hc" {
#   fqdn              = "111.67.218.43"
#   port              = 80
#   type              = "HTTP"
#   resource_path     = "/"
#   failure_threshold = "5"
#   request_interval  = "30"

#   tags = {
#     Name = "idc-health-check"
#   }
# }