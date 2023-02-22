terraform {
  backend "s3" {
    bucket         = "devops-dev-infra-eu-west-1"
    key            = "terraform-state/applicative-infra/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "devops-dev-infra-eu-west-1-locks"
    profile        = "ab-ireland"
  }
}