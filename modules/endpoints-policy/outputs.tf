output "endpoint_policy_json" {
  description = "Generated S3 endpoint policy"
  value       = data.aws_iam_policy_document.s3_endpoint.json
}