data "aws_caller_identity" "current" {}

locals {
  region = "eu-west-1"
  account_id = data.aws_caller_identity.current.account_id
  company_prefix = "ab"
  cluster_name = "${local.company_prefix}-ecs-cluster"
  vpc_id = "vpc-0c3d4622a44529365"
  public_subnets = ["subnet-06509b649d0773fd8", "subnet-0ea6f99cf6a206227", "subnet-078a6b759c337d95c"]
}