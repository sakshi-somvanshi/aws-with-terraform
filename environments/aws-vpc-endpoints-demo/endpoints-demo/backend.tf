terraform {
  backend "s3" {
    bucket = "terraform-state-vpc-peering-2026"
    key    = "Compute/vpc-endpoints-demo/terraform.tfstate"
    region = "ap-south-1"
  }
}