resource "aws_vpc" "gh-vpc" {
  cidr_block = var.vpc-cidr
}

resource "aws_internet_gateway" "gh-igw" {
  vpc_id = aws_vpc.gh-vpc.id
}

resource "aws_subnet" "gh-publicSubnet" {
  vpc_id = aws_vpc.gh-vpc.id
  cidr_block = var.pub-subnet.cidr
  availability_zone = var.pub-subnet.region
  tags = {
    Name = var.pub-subnet.tag
  }
}

resource "aws_route_table" "gh-routeTable" {
  vpc_id = aws_vpc.gh-vpc.id

  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gh-igw.id

  }
  tags = {
    Name = "gh-routeTable"
  }
}

resource "aws_route_table_association" "gh-routeTableAssoc" {
  route_table_id = aws_route_table.gh-routeTable.id
  subnet_id = aws_subnet.gh-publicSubnet.id
}
