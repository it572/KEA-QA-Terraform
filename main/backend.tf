terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "kea-erp-terraform-state"
    key = "qa-server/terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "kea-erp-terraform-locks"
    encrypt = true
  }
}

provider "aws" {
  region = var.aws_region
}
