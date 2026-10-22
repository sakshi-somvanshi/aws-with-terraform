# AWS Cross-Region VPC Peering using Terraform

This project creates two VPCs in different AWS regions and connects them with a VPC peering connection. One EC2 instance runs in each VPC so the private connectivity can be tested.

## Architecture

| | Primary | Secondary |
|---|---|---|
| Region | us-east-1 (N. Virginia) | us-west-2 (Oregon) |
| VPC CIDR | 10.0.0.0/16 | 10.1.0.0/16 |
| Subnet CIDR | 10.0.1.0/24 | 10.1.1.0/24 |
| EC2 | Ubuntu 24.04, t3.micro, Apache | Ubuntu 24.04, t3.micro, Apache |

Peering: the Primary VPC is the **requester**, the Secondary VPC is the **accepter** (auto-accepted). Route tables in both VPCs have a route to the other VPC's CIDR through the peering connection.

## Resources created (18)

- 2 VPCs, 2 subnets
- 2 Internet Gateways, 2 route tables, 2 route table associations
- 1 VPC peering connection and 1 peering accepter
- 2 peering routes (one per VPC)
- 2 security groups (SSH, ICMP and TCP from the peer VPC)
- 2 EC2 instances

## Project structure

```
VPC-Peering-2/
├── backend.tf         # S3 remote state backend
├── provider.tf        # AWS providers (aws.primary, aws.secondary)
├── variables.tf       # Input variables
├── terraform.tfvars   # Variable values
├── data.tf            # AZ and Ubuntu AMI lookups
├── local.tf           # EC2 user_data scripts
├── main.tf            # VPCs, peering, routes, SGs, EC2
└── outputs.tf         # IDs, IPs, test commands
```

## Prerequisites

- Terraform installed and AWS CLI configured (`aws configure`)
- An S3 bucket for remote state (update the bucket name in `backend.tf`)
- An EC2 key pair in **each** region:
  - `vpc-peering-demo-east` in us-east-1
  - `vpc-peering-demo-west` in us-west-2

## Usage

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

## Testing the peering

1. In the EC2 console, connect to the Primary instance (EC2 Instance Connect or SSH).
2. From inside that instance, run (use the Secondary instance's private IP from `terraform output`):

```bash
ping <secondary_private_ip>
curl <secondary_private_ip>
```

Expected result: ping replies with 0% packet loss, and curl returns the Secondary instance's web page (`Secondary VPC Instance - us-west-2`).

## Cleanup

```bash
terraform destroy
```

## Notes

- SSH (port 22) is open to `0.0.0.0/0` for demo purposes. Restrict it to your own IP (`x.x.x.x/32`) for anything beyond a demo.
- Never commit `.pem` key files, `.terraform/` or `*.tfstate` files.
- The two VPC CIDRs must not overlap, otherwise peering fails.

## Key learnings

- Cross-region peering needs a requester and an accepter, each with its own provider alias.
- Peering alone is not enough. Routes and security group rules are required on both sides.
- Private IPs work across regions once peering is active.
