resource "aws_cloudfront_distribution" "tfer--E38MWDVGEO4TGD" {
  aliases = ["*.osmosm.shop"]

  default_cache_behavior {
    allowed_methods          = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cache_policy_id          = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    cached_methods           = ["GET", "HEAD"]
    compress                 = "true"
    default_ttl              = "0"
    max_ttl                  = "0"
    min_ttl                  = "0"
    origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
    smooth_streaming         = "false"
    target_origin_id         = "test-alb-1606956973.us-west-2.elb.amazonaws.com"
    viewer_protocol_policy   = "redirect-to-https"
  }

  enabled         = "true"
  http_version    = "http2"
  is_ipv6_enabled = "true"

  logging_config {
    bucket          = "test-log-cnd-01.s3.amazonaws.com"
    include_cookies = "false"
    prefix          = "CDN_Log"
  }

  origin {
    connection_attempts = "3"
    connection_timeout  = "10"

    custom_header {
      name  = "Test-CDN"
      value = "Test"
    }

    custom_origin_config {
      http_port                = "80"
      https_port               = "443"
      origin_keepalive_timeout = "5"
      origin_protocol_policy   = "https-only"
      origin_read_timeout      = "30"
      origin_ssl_protocols     = ["TLSv1.2"]
    }

    domain_name = "test-alb-1606956973.us-west-2.elb.amazonaws.com"
    origin_id   = "test-alb-1606956973.us-west-2.elb.amazonaws.com"
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  retain_on_delete = "false"

  viewer_certificate {
    acm_certificate_arn            = "arn:aws:acm:us-east-1:687365294585:certificate/7c63421e-7d11-4ae6-a28e-c5157a7b428e"
    cloudfront_default_certificate = "false"
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }

  web_acl_id = "arn:aws:wafv2:us-east-1:687365294585:global/webacl/test-waf_cdn-01/a922ddec-7bb8-49c3-ac44-956a60adba9c"
}
