output "vpc_id" {
  value = aws_vpc.gh-vpc.id
}

output "publicSubnet" {
  value = aws_subnet.gh-publicSubnet.id
}

output "publicSubnetcidr" {
  value = aws_subnet.gh-publicSubnet.cidr_block
}
