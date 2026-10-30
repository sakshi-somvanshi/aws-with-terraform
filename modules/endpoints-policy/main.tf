data "aws_iam_policy_document" "s3_endpoint" {
  statement {
    sid    = "AllowReadOnlyS3Access"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]

    resources = var.s3_resource_arns
  }
}