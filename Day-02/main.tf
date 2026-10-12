
resource "aws_instance" "web_app" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  #   count = var.instance_count
  associate_public_ip_address = var.public_ip

  tags = {
    Name = "web-app"
  }
}

output "instance_public_ip" {
    description = "this is for the aws ec2 public ip"
    value =  aws_instance.web_app.public_ip
}

output "instance_private_ip" {
  description = "this is for the aws ec2 private ip"
    value =  aws_instance.web_app.private_ip
}

output "instance_private_dns" {
    description = "this is for the aws ec2 public ip"
    value = aws_instance.web_app.private_dns
}