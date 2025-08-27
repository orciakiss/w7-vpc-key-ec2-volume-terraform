// Core VPC + Networking

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.vpc1.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.vpc1.cidr_block
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.gw.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = [aws_subnet.public1.id, aws_subnet.public2.id]
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = [aws_subnet.private1.id, aws_subnet.private2.id]
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.rtpublic.id
}

output "private_route_table_id" {
  description = "ID of the private route table"
  value       = aws_route_table.rtprivate.id
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = aws_nat_gateway.nat.id
}

output "eip_allocation_id" {
  description = "Allocation ID of the Elastic IP used by the NAT"
  value       = aws_eip.eip.id
}

// Security Group

output "webserver_security_group_id" {
  description = "ID of the webserver security group"
  value       = aws_security_group.webserver_sg.id
}

// EC2 Instance

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.server1.id
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.server1.public_ip
}

output "instance_private_ip" {
  description = "Private IP of the EC2 instance"
  value       = aws_instance.server1.private_ip
}

output "instance_az" {
  description = "Availability Zone of the EC2 instance"
  value       = aws_instance.server1.availability_zone
}

output "instance_subnet_id" {
  description = "Subnet ID where the instance is launched"
  value       = aws_instance.server1.subnet_id
}

// SSH Key Pair

output "key_pair_name" {
  description = "Name of the AWS key pair"
  value       = aws_key_pair.key1.key_name
}

output "private_key_local_path" {
  description = "Local path of the generated private key (.pem)"
  value       = local_file.localf.filename
  sensitive   = true
}

