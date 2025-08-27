// Ec2 Instance

resource "aws_instance" "server1" {
  ami                    = "ami-045269a1f5c90a6a0"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  key_name               = aws_key_pair.key1.key_name
  user_data              = file("setup.sh")
  tags = {
    Name = "Terraform_instance"
  }
}

// ebs volume
resource "aws_ebs_volume" "ebs" {
  availability_zone = aws_instance.server1.availability_zone
  size = 20
  tags = {
    Name = "Extra-volume"
  }
}
// ebs Volume attachement
resource "aws_volume_attachment" "att" {
  instance_id = aws_instance.server1.id
  volume_id = aws_ebs_volume.ebs.id
  device_name = "/dev/sdb"
}