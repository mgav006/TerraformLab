#First EC2 REsource Block
resource "aws_instance" "FirstTerraEC2" {
  ami                    = var.ec2_ami
  instance_type          = var.ec2_size
  subnet_id              = aws_subnet.terra-sub-a.id
  vpc_security_group_ids = [aws_security_group.FirstTerraformSG.id]

  tags = {
    Name = "FirstTerraEC2"
  }
}

resource "aws_ebs_volume" "disk1" {
  availability_zone = aws_instance.FirstTerraEC2.availability_zone
  size              = 8

  tags = {
    Name = "FirstTFdisk"
  }
}

#resource "aws_volume_attachment" "disk1_attach" {
#device_name = "/dev/sdh"
#volume_id   = aws_ebs_volume.disk1.id
#instance_id = aws_instance.FirstTerraEC2.id

#depends_on = [aws_instance.FirstTerraEC2]
#}

resource "aws_eip" "tf-ec2-pub-ip" {
  instance = aws_instance.FirstTerraEC2.id
  domain   = "vpc"
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.FirstTerraEC2.id
  allocation_id = aws_eip.tf-ec2-pub-ip.id
}