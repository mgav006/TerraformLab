variable "ec2_ami" {
  type    = string
  default = ""
}

variable "ec2_size" {
  type    = string
  default = ""
}

variable "subnet_cidr" {
  type    = list(string)
  default = ["10.0.2.0/24", "10.0.3.0/24"]
}

variable "az_list" {
  type    = list(string)
  default = ["ap-southeast-2b", "ap-southeast-2c"]
}

variable "ebs_size" {
  type    = number
  default = 20
}

variable "Env" {
  type    = string
  default = "prod"
}

variable "boolean" {
  type    = bool
  default = false
}

variable "standard_tags" {
  type = map(string)
  default = {
    env       = "lab"
    costgroup = "Me"
    owner     = "Moi"
  }
}

#Merging Variables (Usually used for tags)



# variable "global_tags" {
#   type = map()
#   default = {
#     Name = "Bhime"
#     Blah = "292U"
#   }
# }