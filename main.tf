provider "aws" {
    alias   = "production"
    profile = "default"
    region  = "us-east-1"
}

module "vpc" {
  source             = "modules/vpc"
  environment        = "production"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  ami                = "ami-00a9d4a05375b2763"
  instance_type      = "t2.nano"
}