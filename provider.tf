terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.74.0"
    }
  }
  backend "s3" {
    bucket = "com-devops"
    key    = "tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.region
}