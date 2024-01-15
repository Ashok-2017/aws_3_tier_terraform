# Creating route table
resource "aws_route_table" "route" {
  vpc_id = "${aws_vpc.astrovpc.id}"
  route {
     cidr_block = "0.0.0.0/0"
     gateway_id = "${aws_internet_gateway.astrogateway.id}"
 }

 tags = {
   Name = "Route to internet" 
}

#Associating route table
resource "aws_route_table_association" "astro1" {
  subnet_id = "${aws_subnet.astrosubnet.id}"
  route_table_id = "${aws_route_table.id}"
}

resource "aws_route_table_association" "astro2" {
  subnet_id = "${aws_subnet.astrosubnet.id}"
  route_table_id = "${aws_route_table.id}"
}

