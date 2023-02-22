module "aws-cicd" {
  source = "../../../modules/infra-network"
  aws_region = local.region
}