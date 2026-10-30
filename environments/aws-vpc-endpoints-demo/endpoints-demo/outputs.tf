output "ec2_public_ip" {
  value = module.ec2.public_ip
}

output "s3_bucket_arn" {
  value = module.s3.bucket_arn
}

output "vpc_endpoint_id" {
  value = aws_vpc_endpoint.s3.id
}