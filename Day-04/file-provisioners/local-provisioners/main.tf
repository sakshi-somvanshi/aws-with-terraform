resource "aws_key_pair" "custom_key" {
  key_name   = "custom-key-local"
  public_key = file("C:\\aws-with-terraform\\Day-04\\file-provisioners\\custom-key.pub")
}



resource "aws_instance" "web_app" {
  ami = var.ami_id
  subnet_id = var.subnet_id
  instance_type = var.instance_type
#   count = var.instance_count
  associate_public_ip_address = var.public_ip
  key_name = aws_key_pair.custom_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
 # Local-exec provisioner (runs locally)

  provisioner "local-exec" {
    command = "echo The instance ${self.public_ip} is now running >> instance_info.txt"
  }


  #user_data = <<-EOF
              #!/bin/bash
   #           apt update -y
    #          sudo apt install nginx -y
     #         sudo apt systemctl start nginx 
      #        echo "Hello World from Inline User Data" > /var/www/html/index.html
       #       EOF


  tags = {
    Name = "sakshi-web-app"
  }
}