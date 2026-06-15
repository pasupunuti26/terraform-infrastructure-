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
