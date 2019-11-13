provider "aws" {
    alias   = "production"
    profile = "default"
    region  = "us-east-1"
}

module "vpc" {
  source             = "modules/vpc"
  environment        = "production"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
}