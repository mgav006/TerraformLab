#Output for the variables represented
output "vpc_id" {
  description = "vpc-id"
  value       = aws_vpc.TerraformVPC.id
}

output "vpc_cidr" {
  description = "vpc-subnet"
  value       = aws_vpc.TerraformVPC.cidr_block
}

output "aws_subnet" {
  description = "vpc-subnet-id and cidr"
  value = zipmap(
    aws_subnet.terra-subnet[*].id,
    aws_subnet.terra-subnet[*].cidr_block
  )
}


# output "aws_subnet_cidr" {
#   description = "subnet"
#   value = 
# }