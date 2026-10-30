variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "ssh_allowed_cidr" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}