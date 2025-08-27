// Code for VPC 
resource "aws_vpc" "vpc1" {
  cidr_block           = "172.120.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name       = "utc-vpc"
    env        = "Dev"
    app-name   = "utc"
    Team       = "wdp"
    created_by = "orcia"
  }
}

// Internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "utc-IGW"
    env  = "Dev"
    Team = "wdp"
  }
}

// Public Subnets
# Public subnets
resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "172.120.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags                    = { Name = "utc-public-sub1" }
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "172.120.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags                    = { Name = "utc-public-sub2" }
}

# Private subnets
resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "172.120.3.0/24"
  availability_zone = "us-east-1a"
  tags              = { Name = "utc-private-sub1" }
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "172.120.4.0/24"
  availability_zone = "us-east-1b"
  tags              = { Name = "utc-private-sub2" }
}


# Nat gateway
resource "aws_eip" "eip" {

}
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public1.id
  tags = {
    Name = "utc-Nat"
    env  = "Dev"
  }
}

# Private route table
resource "aws_route_table" "rtprivate" {
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }
}
// Public route table
resource "aws_route_table" "rtpublic" {
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

// Private route table association
resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.rtprivate.id
}
resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.rtprivate.id
}

// Public  route table association
resource "aws_route_table_association" "rtpub1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.rtpublic.id
}
resource "aws_route_table_association" "rtpub2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.rtpublic.id
}

