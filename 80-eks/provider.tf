terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "= 6.9.0"
    }
  }

  backend "s3" {
    bucket = "84s-remote-state-naresh"
    key    = "roboshop-state-eks"
    region = "us-east-1"
    encrypt        = true
    use_lockfile = true
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}