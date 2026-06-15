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

# =========================
# ROUTE TABLE ASSOCIATIONS
# =========================

resource "aws_route_table_association" "com_web_assoc" {
  subnet_id      = aws_subnet.com_web_sn.id
  route_table_id = aws_route_table.com_public_rt.id
}

resource "aws_route_table_association" "com_api_assoc" {
  subnet_id      = aws_subnet.com_api_sn.id
  route_table_id = aws_route_table.com_public_rt.id
}

resource "aws_route_table_association" "com_db_assoc" {
  subnet_id      = aws_subnet.com_db_sn.id
  route_table_id = aws_route_table.com_private_rt.id
}

# =====================
# COM WEB NACL
# =====================

resource "aws_network_acl" "web_nacl" {
  vpc_id = aws_vpc.com_vpc.id

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  tags = {
    Name = "com-web-nacl"
  }
}

# =====================
# COM API NACL
# =====================

resource "aws_network_acl" "api_nacl" {
  vpc_id = aws_vpc.com_vpc.id

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  tags = {
    Name = "com-api-nacl"
  }
}

# =====================
# COM DB NACL
# =====================

resource "aws_network_acl" "db_nacl" {
  vpc_id = aws_vpc.com_vpc.id

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  tags = {
    Name = "com-db-nacl"
  }
}

# =====================
# COM NACL ASSOCIATIONS
# =====================

resource "aws_network_acl_association" "web_nacl_assoc" {
  network_acl_id = aws_network_acl.web_nacl.id
  subnet_id      = "aws_subnet" "com_web_sn"
}

resource "aws_network_acl_association" "api_nacl_assoc" {
  network_acl_id = aws_network_acl.api_nacl.id
  subnet_id      = "aws_subnet" "com_api_sn"
}

resource "aws_network_acl_association" "db_nacl_assoc" {
  network_acl_id = aws_network_acl.db_nacl.id
  subnet_id      = "aws_subnet" "com_db_sn"
}
