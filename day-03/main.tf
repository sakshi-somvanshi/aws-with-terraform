resource "aws_instance" "web_app" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  #   count = var.instance_count
  associate_public_ip_address = var.public_ip
  key_name = "github-repository"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]



  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              sudo apt install ngnix -y
              echo "Hello World from inline user data" > /var/www/html/index.html
              EOF

  tags = {
    Name = "web-app"
  }
}