provider "aws" {
    #shared_credentials_files = ["C:/Users/USER/.aws/credentials"]
        access_key = var.aws_access_key
        secret_key = var.aws_secret_key
}

#Jenkins에서 변수로 받아온 Key
variable "aws_access_key" {
  type        = string
  description = "AWS access key"
}

variable "aws_secret_key" {
  type        = string
  description = "AWS secret key"
}







