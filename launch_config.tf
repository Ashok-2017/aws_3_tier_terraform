resource "aws_launch_configuration" "web" {
  name_prefix = "web-"
  image_id = " "
  instance_type = "t2.micro"
  key_name = " "

  security_groups = [ "${aws_security_group.astrosg.id}" ]
  associate_public_ip_address = true
  user_data = "${file("data.sh")}"

  lifecycle {
    create_before_destroy = true 
}
}

# I am using create_before_destroy here to create new instances from a new launch configuration before destroying the old ones.
