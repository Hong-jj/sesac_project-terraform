provider "aws" {
    #shared_credentials_files = ["C:/Users/USER/.aws/credentials"]
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_access_key}"
}







