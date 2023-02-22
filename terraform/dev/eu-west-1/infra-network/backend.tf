terraform {
  backend "s3" {
    bucket         = "devops-dev-infra-eu-west-1"
    key            = "terraform-state/infra-network/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "devops-dev-infra-eu-west-1-locks"
    profile        = "ab-ireland"
  }
}