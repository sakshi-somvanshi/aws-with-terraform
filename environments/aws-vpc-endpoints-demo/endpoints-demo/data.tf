data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "terraform-bucket-backend-new"
    key    = "network/vpc-endpoints-demo/terraform.tfstate"
    region = "ap-south-1"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}