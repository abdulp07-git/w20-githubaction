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


  


}
