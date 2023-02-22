variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "VPC id where the load balancer and other resources will be deployed"
  type        = string
  default     = null
}

variable "subnets" {
  description = "A list of subnets to associate with the load balancer"
  type        = list(string)
  default     = null
}

variable "lb_name" {
  description = "The resource name and Name tag of the load balancer"
  type        = string
  default     = null
}

variable "ecs_name" {
  description = "Name of the cluster"
  type        = string
  default     = null
}

variable "ami" {
  description = "Image name"
  type        = string
  default     = null
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = null
}
variable "ecs_task_container_name" {
  description = "ECS task container name"
  type        = string
  default     = null
}

variable "ecs_service_name" {
  description = "ECS service name"
  type        = string
  default     = null
}
variable "task_def_name" {
  description = "ECS task definition name"
  type        = string
  default     = null
}

variable "ecr_name" {
  description = "ECR registry name"
  type        = string
  default     = null
}
