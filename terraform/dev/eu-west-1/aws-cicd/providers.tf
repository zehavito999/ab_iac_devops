terraform {
  required_version = ">= 1.3.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.48.0"
    }
  }
}

provider "aws" {
  region                  = local.region
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "ab-ireland"
}
