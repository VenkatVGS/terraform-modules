# Input Variables
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
# default = "ap-south-1"
}

variable "cidr_vpc" {
  description = "Cidr_Block_For_VPC"
  type = string
# default = "10.0.0.0/16"
}

variable "cidr_public_subnet" {
  description = "Cidr_Block_For_Public_Subnet"
  type = string
#   default = "10.0.1.0/24"
}

variable "cidr_private_subnet" {
  description = "Cidr_Block_For_Private_Subnet"
  type = string
#   default = "10.0.2.0/24"
}

variable "ec2_ami_id" {
  description = "AMI ID"
  type = string  
#   default = "ami-0ad21ae1d0696ad58"
}

variable "sg_ssh" {
  description = "Security_Group_SSH_Port"
  type = number
#   default = 22
}

variable "sg_http" {
  description = "Security_Group_HTTP_Port"
  type = number
#   default = 80
}

variable "private_key" {
  description = "Key_Pair"
  type = string  
#   default = "ajith"
}

