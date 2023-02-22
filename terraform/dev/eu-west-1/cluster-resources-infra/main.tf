
module "cluster-infra" {
  source = "../../../modules/cluster-resources-infra"
  aws_region = local.region
  ami = "ami-06e0ce9d3339cb039"
  lb_name = "alb-${local.cluster_name}"
  subnets = local.public_subnets
  ec2_instance_type = "t2.small"
  ecs_name = local.cluster_name
  task_def_name = "${local.company_prefix}-task"
  ecs_task_container_name = "${local.company_prefix}-container-task"
  ecs_service_name = "${local.company_prefix}-service"
  ecr_name = "${local.company_prefix}-registry"

}
