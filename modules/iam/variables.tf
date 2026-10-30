variable "project_name" {
  description = "Project name"
  type        = string
}

variable "s3_resource_arns" {
  description = "S3 bucket and object ARNs"
  type        = list(string)
}