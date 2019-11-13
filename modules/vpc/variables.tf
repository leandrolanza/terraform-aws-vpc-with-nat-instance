
variable "environment" {}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "private_subnets" {
    type = "list"
    default = [
        "10.0.10.0/24",
        "10.0.11.0/24",
        "10.0.12.0/24"
    ]
}

variable "public_subnets" {
    type = "list"
    default = [
        "10.0.20.0/24",
        "10.0.21.0/24",
        "10.0.22.0/24"
    ]
}

variable "availability_zones" {
    type = "list"
}

variable "map_public_ip_on_launch" {
    default = false
}
