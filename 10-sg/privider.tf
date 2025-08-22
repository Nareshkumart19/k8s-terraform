terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.98.0"
    }
  }

  backend "s3" {
    bucket = "sg-remote-state"
    key    = "sg-remote-state-naresh"
    region = "us-east-1"
    #dynamodb_table = "84s-remote-state-naresh"
    encrypt      = true
    use_lockfile = true #--enable s3 native Locking
  }
}
provider "aws" {
  # Configuration options
  region = "us-east-1"
}