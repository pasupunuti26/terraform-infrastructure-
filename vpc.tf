# =========================
# VPC
# =========================

resource "aws_vpc" "com_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "com-vpc"
  }
}

# =========================
# SUBNETS
# =========================

resource "aws_subnet" "com_web_sn" {
  vpc_id                  = aws_vpc.com_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "com-web-subnet"
  }
}

resource "aws_subnet" "com_api_sn" {
  vpc_id                  = aws_vpc.com_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "com-api-subnet"
  }
}

resource "aws_subnet" "com_db_sn" {
  vpc_id     = aws_vpc.com_vpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "com-db-subnet"
  }
}

# =========================
# INTERNET GATEWAY
# =========================

resource "aws_internet_gateway" "com_igw" {
  vpc_id = aws_vpc.com_vpc.id

  tags = {
    Name = "com-internet-gateway"
  }
}

# =========================
# ROUTE TABLES
# =========================

resource "aws_route_table" "com_public_rt" {
  vpc_id = aws_vpc.com_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.com_igw.id
  }

  tags = {
    Name = "com-public-route"
  }
}

resource "aws_route_table" "com_private_rt" {
  vpc_id = aws_vpc.com_vpc.id

  tags = {
    Name = "com-private-route"
  }
}
