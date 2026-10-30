terraform {
  backend "s3" {
    bucket = "terraform-state-vpc-peering-2026"
    key    = "compute/dev/Ec2/terraform.tfstate"
    region = "ap-south-1"
  }
}