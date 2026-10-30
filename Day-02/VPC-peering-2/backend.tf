terraform {
  backend "s3" {
    bucket = "terraform-state-vpc-peering-2026"
    key    = "networking/VPC-Peering/terraform.tfstate"
    region = "ap-south-1"
  }
}