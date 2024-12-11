variable "ami" {
  type = string
  default = "ami-04b96f981d460859a"
}

variable "key-name" {
  type = string
  default = "my_server_01"
}

variable "vpc_id" {
  type = string
}

variable "securityGroup" {
  type = string
}

variable "InstType" {
  type = string
  default = "t2.medium"
}

variable "publicSubnet" {
  type = string
}
