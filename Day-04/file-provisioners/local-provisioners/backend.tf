terraform {
  backend "s3" {
    bucket = "terraform-state-vpc-peering-2026"
    key    = "compute/Day-04/local-provisioners/terraform.tfstate"
    region = "ap-south-1"
  }
}