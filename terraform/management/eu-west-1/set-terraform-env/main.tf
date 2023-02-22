terraform {
  backend "s3" {
    bucket         = "devops-dev-infra-eu-west-1"
    key            = "terraform-state/management/set-tf-env/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "devops-dev-infra-eu-west-1-locks"
    profile = "ab-ireland"
  }
}

module "set-tf-env" {
  source     = "../../../modules/set-terraform-env"

  region     = local.region
  account_id = local.account_id
  identifiers = [
    "arn:aws:iam::${local.account_id}:user/Zehavito999@gmail.com"
  ]
  tags = {
    owner       = "ab"
    environment = "dev"
    project     = "infrastructure"
    team        = "devops"
    managed   = "terraform"
  }
}
