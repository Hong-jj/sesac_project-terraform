#S3 Bucket 생성
resource "aws_s3_bucket" "django_bucket"{
    bucket = "bts-web-bucket"

    tags ={
        Name = "test bucket"
    }
}

#Bucket에 Policy 적용
resource "aws_s3_bucket_policy" "allow_access"{
    bucket = aws_s3_bucket.django_bucket.id
    policy = data.aws_iam_policy_document.allow_policy.json
}

#Policy 생성
data "aws_iam_policy_document" "allow_policy"{
    statement{
        
        principals {
            type = "*"
            identifiers = ["*"]
        } 

        effect = "Allow"
        
        actions = [
        "s3:GetObject",
        "s3:PutObject",
        ]

        resources = [
            aws_s3_bucket.django_bucket.arn,
            "${aws_s3_bucket.django_bucket.arn}/*",
        ]    
    }    
}

