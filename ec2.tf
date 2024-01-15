resource "aws_instance" "astroinstance" {
  ami = "  "
  instance_type = "t2.micro"
  count = 1
  key_name = "test"
  vpc_security_group_id = ["${aws_security_group.demosg.id}"]
  
   
