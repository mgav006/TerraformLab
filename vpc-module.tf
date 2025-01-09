module "my-vpc-2" {
  source = "../Terraform Modules"
  cidr_block = "10.40.0.0/16"
#my-vpc-igw = "newnewigw"
  az_list = ["ap-southeast-2b", "ap-southeast-2c"]
  subnet_cidr = ["10.40.1.0/24", "10.40.2.0/24"]
}