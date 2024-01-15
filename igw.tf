resource "aws_internet_gateway" "astrogateway" {
  vpc_id = "${aws_vpc.astrovpc.id}"
}

