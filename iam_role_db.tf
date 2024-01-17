data "template_file" "init_db" {
  template = file("./init-db.sql")

  vars = {
    account_service_db_password = var.account_service_db_password
    account_service_db_admin_password = var.account_service_db_admin_password

    question_service_db_password = var.question_service_db_password
    question_service_db_admin_password = var.question_service_db_admin_password
  }
}

# To copy the file 

resource "aws_instance" "bastion" {
  instance_type = "t2.micro" 
}
connection {
 type = "ssh" 
 host = self.public_ip
 user = "ec2-user"
 private_key = file("./astro.pem")
}

provisioner "file" {
  content = data.template_file.init_db.rendered
  destination = "init-db.sql"
}

provisioner "remote-exec" {
 inline = 
    [" sudo yum update -y", 
     " sudo yum install mysql -y", 
     "mysql -u ${var.db_root_username} -h ${aws_db_instance.main.address} -p${var.db_root_password} < init-db.sql"
    ]
}
}










