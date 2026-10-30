output "instance_profile_name" {
  description = "EC2 IAM instance profile name"
  value       = aws_iam_instance_profile.ec2_profile.name
}

output "iam_role_arn" {
  description = "EC2 IAM role ARN"
  value       = aws_iam_role.ec2_role.arn
}