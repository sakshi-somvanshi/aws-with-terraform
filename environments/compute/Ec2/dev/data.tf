data "terraform_remote_state" "vpc_backend" {
 backend = "s3"

  config = {
    bucket = "terraform-state-vpc-peering-2026"
    key    = "Networking/dev/vpc/terraform.tfstate"
    region = "ap-south-1"

}
}