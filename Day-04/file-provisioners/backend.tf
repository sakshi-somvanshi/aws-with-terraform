terraform {
  backend "s3" {
    bucket = "terraform-state-vpc-peering-2026"
    key    = "compute/Day-04/file-provisioners/terraform.tfstate"
    region = "ap-south-1"
  }
}