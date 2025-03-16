variable "aws_region_out" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "ap-south-1"
}

variable "cidr_vpc_out" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "10.0.0.0/16"
}

variable "cidr_public_subnet_out" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "10.0.1.0/24"
}

variable "cidr_private_subnet_out" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "10.0.2.0/24"
}

variable "ec2_ami_id_out" {
  description = "AMI ID"
  type = string  
  default = "ami-0ad21ae1d0696ad58"
}

variable "sg_ssh_out" {
  description = "EC2 Instance Count"
  type = number
  default = 22
}

variable "sg_http_out" {
  description = "EC2 Instance Count"
  type = number
  default = 80
}

variable "private_key_out" {
  description = "Key_Pair"
  type = string  
  default = "ajith"
}
