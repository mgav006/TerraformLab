## TF File for IGWs
#Resource Block for IGW

resource "aws_internet_gateway" "FirstTerraIGWCyber" {
  vpc_id = aws_vpc.TerraformVPC.id

  tags = {
    Name = "TerraIGW"
    Env  = "Test"
  }
}

#Import Existing S3
resource "aws_s3_bucket" "bhimesbucket" {
  bucket = "bhimesbucket"

  tags = {
    Name        = "bhimesbucket"
    Environment = "Dev"
  }
}

#Stateful Backend

terraform {
  backend "s3" {
    bucket         = "bhimesbucket"
    key            = "state/terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "Bhimes-lock"
  }
}

#Create DynamoDB For Log Files
resource "aws_dynamodb_table" "Bhimes-lock" {
  name           = "Bhimes-lock"
  read_capacity  = 2
  write_capacity = 2
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}