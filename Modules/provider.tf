# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#   }
# }

# # Configure the AWS Provider
# provider "aws" {
#   region = var.aws_region_out # ap-south-1 
#   profile = "default"
# }

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "remote" {
    hostname     = "my.scalr.io"  # Your Scalr hostname
    organization = "your-org-name"

    workspaces {
      name = "your-workspace-name"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = var.aws_region_out # ap-south-1 
  profile = "default"
}
