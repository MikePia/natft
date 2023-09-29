# teracert/main.tf

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




module "vpc" {
#   source = "../modules/vpc"
#   vpc_id = module.vpc.vpc_id.id

}