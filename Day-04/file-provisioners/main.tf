resource "aws_key_pair" "custom_key" {
  key_name   = "custom-key"
  public_key = file("custom-key.pub")
}

resource "aws_instance" "web_app" {
  ami                         = var.ami_id
  subnet_id                   = var.subnet_id
  instance_type               = var.instance_type
  associate_public_ip_address = var.public_ip
  key_name                    = aws_key_pair.custom_key.key_name
  vpc_security_group_ids      = [aws_security_group.allow_tls.id]

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("custom-key")
    timeout     = "4m"
  }

  provisioner "file" {
    source      = "index.html"
    destination = "/home/ubuntu/index.html"
  }

  tags = {
    Name = "web-app"
  }
}