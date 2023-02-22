module "aws-cicd" {
  source = "../../../modules/aws-cicd"
  codecommit_repo_name = "${local.company_prefix}-source"
  artifacts_bucket_name = "${local.company_prefix}-s3-artifacts"
  codebuild_project_name = "${local.company_prefix}-codebuild-project"
  codedeploy_app_name = "${local.company_prefix}-codedeploy-app"
  codepipeline_project_name = "${local.company_prefix}-codepipeline-project"
  ecs_cluster_name = local.cluster_name
  ecs_service_name = "${local.company_prefix}-service"
  aws_nlb_listener_arn = local.nlb_arn
  nlb_tg = local.nlb_tg
  nlb_tg_1 = local.nlb_tg_1
}