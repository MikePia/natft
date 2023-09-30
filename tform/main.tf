# tform/main.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "djcoolest"
}

# had to place this in the root and run this command to get it in the configuration:
# terraform import aws_key_pair.mtc_auth mtc_key
resource "aws_key_pair" "mtc_auth" {
  key_name   = "mtc_key"
  public_key = file("~/.ssh/mtc_key.pub")
}

module "vpc" {
  source = "../modules/vpc"
}

# variable "ami_id" {}
module "ec2" {
  source               = "../modules/ec2"
  ami_id               = data.aws_ami.mtc_ec2.id
  mtc_security_id      = module.vpc.mtc_security_id
  mtc_public_subnet_id = module.vpc.mtc_public_subnet_id
  key_pair_id          = aws_key_pair.mtc_auth.id
}