# =========================
# VPC
# =========================

resource "aws_vpc" "crm_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "crm-vpc"
  }
}

vpc.tf
resource "aws_subnet" "crm_web_sn" {
  vpc_id                  = vpc-0045c8ccc4239220b
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "crm_web_sn-subnet"
  }
}