# Defining Public Key
variable "public_key" {
  default = "astro.pub"
}
# Defining Private Key
variable "private_key" {
  default = "astro.pem"
}
# Definign Key Name for connection
variable "key_name" {
  default = "tests"
  description = "Name of AWS key pair"
}
# Defining CIDR Block for VPC
variable "vpc_cidr" {
  default = "10.0.0.0/8"
}
# Defining CIDR Block for Subnet
variable "subnet_cidr" {
  default = "10.0.1.0/16"
}
# Defining CIDR Block for 2d Subnet
variable "subnet1_cidr" {
  default = "10.0.2.0/16"
}
