terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "kratos-terraform-state-file"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "kratos-state-lock"
    encrypt = true
  }
}

provider "aws" {
  region = var.aws_region
}
