resource "aws_instance" "gh-tomcat" {
  ami = var.ami
  instance_type = var.InstType
  vpc_security_group_ids = [var.securityGroup]
  subnet_id = var.publicSubnet
  associate_public_ip_address = true
  key_name = var.key-name
  tags = {
    Name = "gh-tomcat"
  }


  provisioner "file" {
    source      = "app.war"
    destination = "/opt/tomcat/webapps"
    connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = file("${path.module}/keys/my_server_01.pem")
      host     = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo systemctl daemon-reload",
      "sudo systemctl restart tomcat.service"
    ]
    connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = file("${path.module}/keys/my_server_01.pem")
      host     = self.public_ip
    }
  }


}
