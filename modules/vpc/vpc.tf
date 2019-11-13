resource "aws_vpc" "this" {
    cidr_block           = "${var.vpc_cidr}"
    enable_dns_hostnames = "${local.enable_dns_hostnames}"
    enable_dns_support   = "${local.enable_dns_support}"
    tags {
        Name        = "VPC-${var.environment}"
        Environment = "${var.environment}"
    }
}
