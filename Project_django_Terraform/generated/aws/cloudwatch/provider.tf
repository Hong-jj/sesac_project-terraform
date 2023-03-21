provider "aws" {
  region = "us-west-2"
}

terraform {
	required_providers {
		aws = {
	    version = "~> 4.58.0"
		}
  }
}
