data "aws_caller_identity" "current" {}

locals {
  region = "eu-west-1"
  account_id = data.aws_caller_identity.current.account_id
  company_prefix = "ab"
  cluster_name = "${local.company_prefix}-ecs-cluster"
  nlb_arn = "arn:aws:elasticloadbalancing:eu-west-1:608765303368:loadbalancer/net/alb-ab-ecs-cluster/8c0592c10481793c"
  nlb_tg = "arn:aws:elasticloadbalancing:eu-west-1:608765303368:targetgroup/nlb-tg/bbd67befa4846f0b"
  nlb_tg_1 = "arn:aws:elasticloadbalancing:eu-west-1:608765303368:targetgroup/nlb-tg-1/b4b2a8f1ced53f07"
}