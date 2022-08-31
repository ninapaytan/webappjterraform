# Creating a VPC

resource "aws_vpc" "vpc-adolfo" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "adolfo-vpc"
  }
}

# Creating 4 subnets (2 privates and 2 publics)

# public subnet a
resource "aws_subnet" "subnet-a-public" {
  cidr_block = "10.0.0.0/24"
  vpc_id = aws_vpc.vpc-adolfo.id
  availability_zone = var.adolfo-az-a
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-a-public"
  }
}

# private subnet a
resource "aws_subnet" "subnet-a-private" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.vpc-adolfo.id
  availability_zone = var.adolfo-az-a
  tags = {
    Name = "subnet-a-private"
  }
}

# public subnet b
resource "aws_subnet" "subnet-b-public" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.vpc-adolfo.id
  availability_zone = var.adolfo-az-b
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-b-public"
  } 
}

# private subnet b
resource "aws_subnet" "subnet-b-private" {
  cidr_block = "10.0.3.0/24"
  vpc_id = aws_vpc.vpc-adolfo.id
  availability_zone = var.adolfo-az-b
  tags = {
    Name = "subnet-b-private"
  }  
}

# Creating Internet Gateway
resource "aws_internet_gateway" "ig-adolfo" {
  vpc_id = aws_vpc.vpc-adolfo.id
  tags = {
    Name = "ig-adolfo"
  }
}

# Creating Elastic IP for NAT Gateway
resource "aws_eip" "eip-ng-adolfo" {
  vpc = true
  tags = {
    Name = "eip-ng-adolfo"
  }
}

# Creating NAT Gateway
resource "aws_nat_gateway" "ng-adolfo" {
  allocation_id = aws_eip.eip-ng-adolfo.id
  subnet_id = aws_subnet.subnet-a-public.id
  depends_on = [aws_internet_gateway.ig-adolfo]
  tags = {
    Name = "ng-adolfo"
  }
}

# Creating 2 route tables

# public route table
resource "aws_route_table" "rt-public-adolfo" {
  vpc_id = aws_vpc.vpc-adolfo.id
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig-adolfo.id
  }
  tags = {
    Name = "rt-public-adolfo"
  }
}

# private route table
resource "aws_route_table" "rt-private-adolfo" {
  vpc_id = aws_vpc.vpc-adolfo.id
  route{
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ng-adolfo.id
  }
  tags = {
    Name = "rt-private-adolfo"
  }
}

# Associating the Public subnet a to public route table
resource "aws_route_table_association" "adolfo-a-pub" {
  route_table_id = aws_route_table.rt-public-adolfo.id
  subnet_id = aws_subnet.subnet-a-public.id
}

# Associating the Public subnet b to public route tables
resource "aws_route_table_association" "adolfo-b-pub" {
  route_table_id = aws_route_table.rt-public-adolfo.id
  subnet_id = aws_subnet.subnet-b-public.id
}

# Associating the Private subnet a to private route table
resource "aws_route_table_association" "adolfo-a-priv" {
  route_table_id = aws_route_table.rt-private-adolfo.id
  subnet_id = aws_subnet.subnet-a-private.id
}

# Associating the Private subnet b to private route table
resource "aws_route_table_association" "adolfo-b-priv" {
  route_table_id = aws_route_table.rt-private-adolfo.id
  subnet_id = aws_subnet.subnet-b-private.id
}