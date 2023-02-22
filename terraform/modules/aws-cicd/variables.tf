variable "codecommit_repo_name" {
  description = "Name of the Source CodeCommit repository used by the pipeline"
  type        = string
  default     = null
}
variable "artifacts_bucket_name" {
  description = "Artifacts bucket name"
  type        = string
  default     = null
}
variable "codebuild_project_name" {
  description = "Codebuild project name"
  type        = string
  default     = null
}
variable "codedeploy_app_name" {
  description = "Codedeploy app name"
  type        = string
  default     = null
}
variable "codepipeline_project_name" {
  description = "Codepipeline project name"
  type        = string
  default     = null
}
variable "ecs_cluster_name" {
  description = "ECS cluster name"
  type        = string
  default     = null
}
variable "ecs_service_name" {
  description = "ECS cluster service name"
  type        = string
  default     = null
}
variable "aws_nlb_listener_arn" {
  description = "NLB listener arn"
  type        = string
  default     = null
}
variable "nlb_tg" {
  description = "NLB blue deployment target group"
  type        = string
  default     = null
}
variable "nlb_tg_1" {
  description = "NLB green deployment target group"
  type        = string
  default     = null
}

