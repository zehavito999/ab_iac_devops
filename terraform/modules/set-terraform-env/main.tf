data "aws_caller_identity" "current" {}

locals {
  tfstate_bucket = "devops-${lookup(var.tags, "environment")}-infra-${var.region}"
  bucket_arn     = "arn:aws:s3:::${local.tfstate_bucket}"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = local.tfstate_bucket
  acl    = "private"
  versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = merge(var.tags, { Name = local.tfstate_bucket, Region = var.region })
}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_object" "directory" {
  bucket = aws_s3_bucket.terraform_state.id
  for_each = toset(
  [
    "terraform-state"
  ]
  )
  key = "${each.key}/"
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.terraform_state.id
  policy = data.aws_iam_policy_document.bucket_policy_doc.json
}

data "aws_iam_policy_document" "bucket_policy_doc" {
  statement {
    principals {
      identifiers = concat(var.identifiers, [aws_iam_role.devops-role.arn])
      type        = "AWS"
    }
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = [local.bucket_arn]
  }
  statement {
    principals {
      identifiers = concat(var.identifiers, [aws_iam_role.devops-role.arn])
      type        = "AWS"
    }
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]
    resources = [
      local.bucket_arn,
      "${local.bucket_arn}/backup/*",
      "${local.bucket_arn}/config/*",
      "${local.bucket_arn}/logs/*",
      "${local.bucket_arn}/terraform-state/*",
    ]
  }
}

resource "aws_dynamodb_table" "dynamodb_terraform_locks" {
  name         = "${local.tfstate_bucket}-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }

  tags = merge(var.tags, { Name = "${local.tfstate_bucket}-locks", service = "dynamodb" })
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = var.identifiers
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "devops-role" {
  name               = "devops-admin"
  description        = "devops admin role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "AdministratorAccess" {
  role       = aws_iam_role.devops-role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
