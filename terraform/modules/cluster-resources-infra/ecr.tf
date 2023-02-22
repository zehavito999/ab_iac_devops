resource "aws_ecr_repository" "ecr_registry" {
  name = var.ecr_name
}
