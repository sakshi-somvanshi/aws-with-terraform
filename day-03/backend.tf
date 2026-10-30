terraform {
  backend "s3" {
    bucket = "terraform-remote-backend-fct-batch"
    key    = "compute/day-03/terraform.tfstate"
    region = "ap-south-1"
  }
}