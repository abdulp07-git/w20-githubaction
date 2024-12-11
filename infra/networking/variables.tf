variable "vpc-cidr" {
  type = string
  default = "10.0.0.0/24"
}

variable "pub-subnet" {
  type = map(string)
  default = {
    "tag" = "publicSubnet"
    "cidr" = "10.0.0.0/24"
    "region" = "ap-south-1a"
  }
}
