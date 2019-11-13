resource "aws_subnet" "this-private" {
    vpc_id                  = "${aws_vpc.this.id}"
    count                   = "${length(var.private_subnets)}"
    cidr_block              = "${element(var.private_subnets, count.index)}"
    availability_zone       = "${var.availability_zones[count.index]}"
    map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
    tags {
        Name        = "Sub-pri-${var.environment}-${element(var.availability_zones, count.index)}"
        Environment = "${var.environment}"
    }
}

resource "aws_subnet" "this-public" {
    vpc_id                  = "${aws_vpc.this.id}"
    count                   = "${length(var.public_subnets)}"
    cidr_block              = "${element(var.public_subnets, count.index)}"
    availability_zone       = "${var.availability_zones[count.index]}"
    map_public_ip_on_launch = true
    tags {
        Name        = "Sub-pub-${var.environment}-${element(var.availability_zones, count.index)}"
        Environment = "${var.environment}"
    }
}
