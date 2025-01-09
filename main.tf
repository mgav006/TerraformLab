#Provider block expressing which CLoud provider is being used

provider "aws" {
  region     = "ap-southeast-2" #sydney region
}

#VPC Resource Block - The VPC has to be unique
resource "aws_vpc" "TerraformVPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "FirstTestTerraformVPC"
    Env  = "Test"
  }
}

#First Subnet Resource Block
resource "aws_subnet" "terra-sub-a" {
  vpc_id            = aws_vpc.TerraformVPC.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-southeast-2a"

  tags = {
    Name = "FirstTestTerraformSubnet"
  }
}

#Make Multiple Subnets
resource "aws_subnet" "terra-subnet" {
  count             = 2 #if you do {count - length(var.az_list) it will make just the ones in the tfvar file
  vpc_id            = aws_vpc.TerraformVPC.id
  cidr_block        = var.subnet_cidr[count.index]
  availability_zone = var.az_list[count.index]
    tags = merge(
        var.standard_tags,
        {
    Name = "terra-subnet-${count.index + 1}"
        }
    )
}

#Datasource example
# data "terraform_remote_state" "my-vpc" {
#     backend = "s3"

#     config  = {

#         bucket = "blah"
#         key = "blah"
#         region = "blah"
#     }

# }

# resource "aws_instance" "test-instance" {
#   ami = "blah"
#   instance_type = "blah"
#   subnet_id = data.terraform_remote_state.m-vpc.outputs.pub_subnets[0]
# }

#Locals
locals {
  subnet_cidr = ["10.0.2.0/24", "10.0.3.0/24"]
}

#First Security Group
resource "aws_security_group" "FirstTerraformSG" {
  name        = "CyberTerraEC2"
  description = "FirstTerraformSG"
  vpc_id      = aws_vpc.TerraformVPC.id

  tags = {
    Name = "CyberTerra"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}








#VPC Resource Block Imported
#No tags required for this
# resource "aws_vpc" "imported-vpc" {
#   cidr_block       = "192.168.0.0/20"
#   instance_tenancy = "default"

#   tags = {
#     Name = "ImportedBhimeVPC"
#     Env  = "Mix"
#   }
# }

#Imported Subnets
# resource "aws_subnet" "imported-sub-a" {
#   vpc_id            = aws_vpc.imported-vpc.id
#   cidr_block        = "192.168.0.0/24"
#   availability_zone = "ap-southeast-2a"
# }

# resource "aws_subnet" "imported-sub-b" {
#   vpc_id            = aws_vpc.imported-vpc.id
#   cidr_block        = "192.168.1.0/24"
#   availability_zone = "ap-southeast-2b"
# }

# resource "aws_subnet" "imported-sub-c" {
#   vpc_id            = aws_vpc.imported-vpc.id
#   cidr_block        = "192.168.2.0/24"
#   availability_zone = "ap-southeast-2c"
# }
