terraform {
  backend "s3" {
    bucket = "terraform-remote-backend-fct-batch"
    key    = "compute/dev-workspaces/terraform.tfstate"
    region = "ap-south-1"
  }
}