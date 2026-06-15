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
