
# Router Public
resource "aws_route_table" "this-public" {
    vpc_id = "${aws_vpc.this.id}"
    tags {
        Name        = "RTB-Public-${var.environment}"
        Environment = "${var.environment}"
    }
}

resource "aws_route" "this-route-public" {
    route_table_id         = "${aws_route_table.this-public.id}"
    destination_cidr_block = "${local.destination_public}"
    gateway_id             = "${aws_internet_gateway.this.id}"
}

resource "aws_route_table" "this-private" {
    vpc_id = "${aws_vpc.this.id}"
    tags {
        Name        = "RTB-Private-${var.environment}"
        Environment = "${var.environment}"
    }
}

resource "aws_route" "this-route-private" {
    route_table_id         = "${aws_route_table.this-private.id}"
    destination_cidr_block = "0.0.0.0/0"
    network_interface_id   = "${aws_network_interface.this.id}"
}

resource "aws_eip_association" "this" {
    instance_id   = "${aws_instance.this.id}"
    allocation_id = "${aws_eip.this.id}"
}

resource "aws_route_table_association" "this-public" {
    count          = "${length(var.public_subnets)}"
    subnet_id      = "${element(aws_subnet.this-public.*.id, count.index)}"
    route_table_id = "${aws_route_table.this-public.id}"  
}

resource "aws_main_route_table_association" "this" {
    vpc_id         = "${aws_vpc.this.id}"
    route_table_id = "${aws_route_table.this-private.id}"
}
