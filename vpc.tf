resource "aws_vpc" "amirk-tf-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "amirk-tf-vpc"
  }
}

resource "aws_subnet" "amirk-tf-public-subnet-1a" {
  vpc_id                  = aws_vpc.amirk-tf-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "amirk-tf-public-1a"
  }
}

resource "aws_subnet" "amirk-tf-public-subnet-1b" {
  vpc_id                  = aws_vpc.amirk-tf-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "amirk-tf-public-1b"
  }
}

resource "aws_internet_gateway" "amirk-tf-igw" {
  vpc_id = aws_vpc.amirk-tf-vpc.id

  tags = {
    Name = "amirk-tf-igw"
  }
}

resource "aws_route_table" "amirk-tf-public-rt" {
  vpc_id = aws_vpc.amirk-tf-vpc.id

  tags = {
    Name = "amirk-tf-public-rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.amirk-tf-public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.amirk-tf-igw.id
}

resource "aws_route_table_association" "amirk-tf-public-assoc-1a" {
  subnet_id      = aws_subnet.amirk-tf-public-subnet-1a.id
  route_table_id = aws_route_table.amirk-tf-public-rt.id
}

resource "aws_route_table_association" "amirk-tf-public-assoc-1b" {
  subnet_id      = aws_subnet.amirk-tf-public-subnet-1b.id
  route_table_id = aws_route_table.amirk-tf-public-rt.id
}

resource "aws_security_group" "amirk-tf-sg" {
  name        = "amirk-tf-sg"
  description = "terraform intro security group"
  vpc_id      = aws_vpc.amirk-tf-vpc.id

  # Allow SSH only from your IP address
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["147.235.205.129/32"]
  }

  # Allow HTTP from everywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS from everywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "amirk-auth" {
  key_name   = "aws-ssh"
  public_key = file("~/.ssh/aws-ssh.pub")
}