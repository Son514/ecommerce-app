# Define the AWS provider and set the region to ap-southeast-1
provider "aws" {
  region = "ap-southeast-1"
}

# Create a VPC with a 10.0.0.0/16 CIDR block
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# Define a public subnet within the VPC
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-southeast-1a" # Replace with a suitable availability zone
}

# Attach an Internet Gateway to the VPC for internet access
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

# Create a route table to allow outbound internet access
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

# Associate the route table with the public subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Define a security group to allow SSH, HTTP, Jenkins, and MicroK8s access
resource "aws_security_group" "allow_ssh_http" {
  vpc_id = aws_vpc.main.id
  name   = "allow_ssh_http"

  # Allow SSH access from anywhere (Port 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP access from anywhere (Port 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow Jenkins access (Port 8080)
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow MicroK8s API access (Port 16443)
  ingress {
    from_port   = 16443
    to_port     = 16443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define an EC2 instance for Jenkins, Docker, and MicroK8s
resource "aws_instance" "jenkins_k8s" {
  ami             = "ami-08a86874cc6c57045" # Replace with a suitable AMI
  instance_type   = "t3.small"
  subnet_id       = aws_subnet.public.id
  key_name        = "jenkins_k8s-key-pairs" # Replace with your key pair name
  security_groups = [aws_security_group.allow_ssh_http.id]

  # Assign a public IP to the instance
  associate_public_ip_address = true

  # Tags for identification
  tags = {
    Name = "Jenkins-K8s-Server"
  }
}

# Output the public IP of the instance
output "instance_public_ip" {
  value = aws_instance.jenkins_k8s.public_ip
}