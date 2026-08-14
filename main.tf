# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "demo_project_vpc"
  }
}
# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "my-server-IGW2"
  }
}
# Public Subnet 1
resource "aws_subnet" "public_subnet1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr_block1
  map_public_ip_on_launch = true
  tags = {
    Name = "my-server-Public-Subnet1"
  }
}
# Public Subnet 2
resource "aws_subnet" "public_subnet2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr_block2
  map_public_ip_on_launch = true
  tags = {
    Name = "my-server-Public-Subnet2"
  }
}
# Public Subnet 2
resource "aws_subnet" "public_subnet3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr_block3
  map_public_ip_on_launch = true
  tags = {
    Name = "my-server-Public-Subnet3"
  }
}
# Route Table for Public Subnet1
resource "aws_route_table" "public_route_table1" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "my-server-Public-RT2"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}
# Route Table for Public Subnet2
resource "aws_route_table" "public_route_table2" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "my-server-Public-RT2"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}
# Route Table for Public Subnet3
resource "aws_route_table" "public_route_table3" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "my-server-Public-RT3"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}
# Associate Public Route Table with Public Subnet1
resource "aws_route_table_association" "public_assoc1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_route_table1.id
}
# Associate Public Route Table with Public Subnet2
resource "aws_route_table_association" "public_assoc2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_route_table2.id
}
# Associate Public Route Table with Public Subnet3
resource "aws_route_table_association" "public_assoc3" {
  subnet_id      = aws_subnet.public_subnet3.id
  route_table_id = aws_route_table.public_route_table3.id
}
# EC2 Instance in the Public Subnet 1
resource "aws_instance" "web_public1" {
  ami                         = var.ami
  instance_type               = var.instance_type
  availability_zone           = var.avail_zone1
  subnet_id                   = aws_subnet.public_subnet1.id
  associate_public_ip_address = true
  user_data                   = file("nginx.sh")
  vpc_security_group_ids      = [aws_security_group.allow_web.id]
  key_name                    = "chris"
  tags = {
    Name = "demo_project_server1"
  }
}
# EC2 Instance in the Public Subnet 2
resource "aws_instance" "web_public2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  availability_zone           = var.avail_zone2
  subnet_id                   = aws_subnet.public_subnet2.id
  associate_public_ip_address = true
  user_data                   = file("apache2.sh")
  vpc_security_group_ids      = [aws_security_group.allow_web.id]
  key_name                    = "chris"
  tags = {
    Name = "demo_project_server2"
  }
}
# EC2 Instance in the Public Subnet 3
resource "aws_instance" "web_public3" {
  ami                         = var.ami
  instance_type               = var.instance_type
  availability_zone           = var.avail_zone3
  subnet_id                   = aws_subnet.public_subnet3.id
  associate_public_ip_address = true
  user_data                   = file("jenkins.sh")
  vpc_security_group_ids      = [aws_security_group.allow_web.id]
  key_name                    = "chris"
  tags = {
    Name = "demo_project_server3"
  }
}