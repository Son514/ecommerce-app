# Configure the AWS provider
provider "aws" {
  region = "ap-southeast-1" # Set your preferred AWS region
}

# Create a VPC named ecommerce-vpc
resource "aws_vpc" "ecommerce_vpc" {
  cidr_block           = "10.0.0.0/16" # Private IP range for the VPC
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "ecommerce-vpc"
  }
}

# Create a subnet within the VPC
resource "aws_subnet" "ecommerce_subnet" {
  vpc_id            = aws_vpc.ecommerce_vpc.id
  cidr_block        = "10.0.1.0/24"     # Subnet IP range
  availability_zone = "ap-southeast-1a" # Adjust based on your region
  tags = {
    Name = "ecommerce-subnet"
  }
}

# Create an Internet Gateway for public access
resource "aws_internet_gateway" "ecommerce_igw" {
  vpc_id = aws_vpc.ecommerce_vpc.id
  tags = {
    Name = "ecommerce-igw"
  }
}

# Create a route table for public access
resource "aws_route_table" "ecommerce_route_table" {
  vpc_id = aws_vpc.ecommerce_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ecommerce_igw.id
  }
  tags = {
    Name = "ecommerce-route-table"
  }
}

# Associate the route table with the subnet
resource "aws_route_table_association" "ecommerce_route_assoc" {
  subnet_id      = aws_subnet.ecommerce_subnet.id
  route_table_id = aws_route_table.ecommerce_route_table.id
}

# Create a security group to allow SSH and HTTP
resource "aws_security_group" "ecommerce_sg" {
  vpc_id = aws_vpc.ecommerce_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allows SSH from any IP (restrict in production)
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allows HTTP access
  }
  ingress {
    from_port   = 31612
    to_port     = 31612
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allows access to port 31612 from any IP (restrict in production)
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allows all outbound traffic
  }
  tags = {
    Name = "ecommerce-sg"
  }
}

# Create an EC2 instance named ecommerce-server
resource "aws_instance" "ecommerce_server" {
  ami                         = "ami-022710250568671dc" # Amazon Linux 2 AMI (us-east-1, Free Tier eligible)
  instance_type               = "t2.xlarge"             # Free Tier eligible
  subnet_id                   = aws_subnet.ecommerce_subnet.id
  vpc_security_group_ids      = [aws_security_group.ecommerce_sg.id]
  key_name                    = "ec2-key-pairs" # Existing key pair for SSH
  associate_public_ip_address = true            # Assign a public IP for SSH access
  tags = {
    Name = "ecommerce-server"
  }
}