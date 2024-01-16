# Create a data base security group
resource "aws_security_group" "database-sg" {
  name = "Database sg"
  description = "Allow inbound traffic from application layer"
  vpc_id = "${aws_vpc.astrovpc.id}"

  ingress {
    description = "Allow traffic from application layer"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = [aws_security_group.astrosg.id]
  }

  egress {
    from_port = 32768
    to_port = 65535
    protocol = "tcp"
    cidr_block = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Database SG"
  }

# I have opened 3306 ports for the inbound connection and I have opened all the ports for the outbound connection.



