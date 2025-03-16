module "vpc" {
  source = "./modules/aws-vpc"
  aws_region = var.aws_region_out
  cidr_vpc = var.cidr_vpc_out
  cidr_public_subnet = var.cidr_public_subnet_out
  cidr_private_subnet = var.cidr_private_subnet_out
  ec2_ami_id = var.ec2_ami_id_out
  sg_ssh = var.sg_ssh_out
  sg_http = var.sg_http_out
  private_key = var.private_key_out

}