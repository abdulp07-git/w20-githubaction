variable "vpc_id" {
  type = string
}

variable "publicSubnetID" {
  type = string
}

variable "publicSubnetcidr" {
  type = string
}

variable "ports" {
  type = list(map(string))
  default = [ 
    {
    "port" = "22"
  },
  {
    "port" = "8080"
  } 
  
  ]
}
