resource "aws_vpc" "astrovpc" { 
  cidr_block = "{var.cidr_block}"
  instance_tenancy = "default"
  tags = {
    Name = "astrovpc" 
  }
}

