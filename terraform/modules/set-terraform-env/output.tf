output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "region" {
  value = var.region
}

output "terraform_state_s3_bucket_arn" {
  value = aws_s3_bucket.terraform_state.arn
}
output "terraform_state_s3_bucket_name" {
  value = aws_s3_bucket.terraform_state.bucket_domain_name
}

output "devops-admin-role" {
  value = aws_iam_role.devops-role.arn
}
