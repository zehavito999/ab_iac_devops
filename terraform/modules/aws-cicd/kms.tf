data "aws_caller_identity" "current" {}
data "aws_iam_policy_document" "artifacts_kms_policy" {
  policy_id = "key-default-1"
  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions = [
      "kms:*",
    ]
    resources = [
      "*",
    ]
  }
}
resource "aws_kms_key" "kms_artifacts" {
  description = "KMS key for artifacts"
  policy      = data.aws_iam_policy_document.artifacts_kms_policy.json
}
resource "aws_kms_alias" "artifacts_kms_alias" {
  name          = "alias/ab-kms-artifacts"
  target_key_id = aws_kms_key.kms_artifacts.key_id
}