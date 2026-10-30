module "s3" {
  source = "../../../modules/s3"

  bucket_name = var.bucket_name
  environment = var.environment
}

module "iam" {
  source = "../../../modules/iam"

  project_name = var.project_name

  s3_resource_arns = [
    module.s3.bucket_arn,
    "${module.s3.bucket_arn}/*"
  ]
}

module "security_group" {
  source = "../../../modules/security-group"

  project_name     = var.project_name
  vpc_id           = data.terraform_remote_state.network.outputs.vpc_id
  ssh_allowed_cidr = var.ssh_allowed_cidr
}

module "ec2" {
  source = "../../../modules/ec2"

  project_name          = var.project_name
  environment           = var.environment
  ami_id                = data.aws_ami.ubuntu.id
  instance_type         = var.instance_type
  subnet_id             = data.terraform_remote_state.network.outputs.public_subnet_id
  security_group_id     = module.security_group.security_group_id
  instance_profile_name = module.iam.instance_profile_name
}

module "endpoint_policy" {
  source = "../../../modules/endpoints-policy"

  s3_resource_arns = [
    module.s3.bucket_arn,
    "${module.s3.bucket_arn}/*"
  ]
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = data.terraform_remote_state.network.outputs.vpc_id
  service_name      = "com.amazonaws.ap-south-1.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    data.terraform_remote_state.network.outputs.public_route_table_id
  ]

  policy = module.endpoint_policy.endpoint_policy_json

  tags = {
    Name        = "${var.project_name}-s3-endpoint"
    Environment = var.environment
  }
}