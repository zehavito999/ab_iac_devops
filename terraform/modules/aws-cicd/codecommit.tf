resource "aws_codecommit_repository" "code_commit_repo" {
  repository_name = var.codecommit_repo_name
  description     = "code commit repository name"
}
