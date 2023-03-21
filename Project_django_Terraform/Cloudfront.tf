# 현재 프로젝트(backup region)는 Cloudfront를 GUI로 1개만 생성(수정 X)
# # AWS CloudFront Distribution 생성
# resource "aws_cloudfront_distribution" "web_distribution" {
#   origin {
#     domain_name = aws_lb.main.dns_name
#     origin_id   = aws_lb.main.dns_name

#     custom_origin_config {
#       http_port              = 80
#       https_port             = 443
#       origin_protocol_policy = "http-only"
#       origin_ssl_protocols   = ["TLSv1.2"]
#     }
#   }

#   enabled             = true
#   is_ipv6_enabled     = true
#   comment             = "Web distribution"
#   default_root_object = "index.html"

#   # CloudFront에 연결할 SSL 인증서 ARN
#   viewer_certificate {
#     acm_certificate_arn = "arn:aws:acm:us-east-1:881855020500:certificate/d082e57f-eded-41b2-b77a-54aa3d74a39c"
#     ssl_support_method  = "sni-only"
#   }
#   # ALB의 DNS 이름을 CNAME으로 등록
#   aliases = ["www.hkang.shop"]


#   # HTTP 요청을 HTTPS로 리디렉션합니다.
#   default_cache_behavior {
#     cache_policy_id  = var.cache_policy_id
#     allowed_methods  = ["GET", "HEAD", "OPTIONS"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = aws_lb.main.dns_name
#     compress         = true

#     viewer_protocol_policy = "redirect-to-https" //http로 들어오면 https로 바꿔 cloudfront의 인증서로 처리함
#     min_ttl                = 0
#     default_ttl            = 3600
#     max_ttl                = 86400
#   }

#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#     }
#   }

#   tags = {
#     Environment = "Production"
#   }
# }