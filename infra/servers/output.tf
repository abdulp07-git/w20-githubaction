output "publicDNS" {
  value = aws_instance.gh-tomcat.public_dns
}

output "ec2_public_ip" {
  value = aws_instance.gh-tomcat.public_ip
}
