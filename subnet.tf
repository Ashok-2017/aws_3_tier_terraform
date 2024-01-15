#Creating first web subnet
resource "aws_subnet" "public-subnet-1" {
  vpc_id = "${aws_vpc.astrovpc.id}"
  cidr_block = "${var.subnet_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "us-west-1a"

tags = {
  Name = "Web subnet 1" 
  }
}

#Creating second web subnet
resource "aws_subnet" "public-subnet-2" {
  vpc_id = "${aws_vpc.astrovpc.id}"
  cidr_block = "${var.subnet_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "us-west-2b"

  tags = {
   Name = " web subnet 2"
}
}

#Creating first application subnet
resource "aws_subnet" "application-subnet-1" {
 vpc_id = "${aws_vpc.astrovpc.id}"
 cidr_block = "${var.subnet_cidr}"
 map_public_ip_on_launch = false
 availability_zone = "us-west-1a"

 tags = {
   Name = " application subnet 1"
}
}

#Creating second application subnet
resource "aws_subnet" "application-subnet-2" {
  vpc_id = "${aws_vpc.astrovpc.id}"
  cidr_block = "${var.subnet_cidr}"
  map_public_ip_on_launch = false
  availability_zone = "us-west-2b"

  tags = {
    Name = " application subnet 2" 
    }
}

#Create a database private subnet
resource "aws_subnet" "database-subnet-1" {
  vpc_id = "${aws_vpc.astrovpc.id}"
  cidr_block = "${var.cidr_block}"
  availability_zone = "us-west-1a" 
  tags = {
    Name = "Database subnet 1"
} 
}

# Create Database Private Subnet
resource "aws_subnet" "database-subnet-2" {
  vpc_id            = "${aws_vpc.demovpc.id}"
  cidr_block        = "${var.subnet5_cidr}"
  availability_zone = "us-west-2b"
tags = {
    Name = "Database Subnet 2"
  }
}












 


  

