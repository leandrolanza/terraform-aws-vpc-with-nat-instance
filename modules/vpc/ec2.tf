resource "aws_network_interface" "this" {
    subnet_id         = "${aws_subnet.this-public.0.id}"
    source_dest_check = false
    security_groups   = ["${aws_security_group.this.id}"]
    tags {
        Name        = "ENI-NAT-${var.environment}"
        Environment = "${var.environment}"
    }
}

resource "aws_eip" "this" {
    vpc               = true
    network_interface = "${aws_network_interface.this.id}"
}

resource "aws_instance" "this" {
    ami           = "${var.ami}"
    instance_type = "${var.instance_type}"
    tags {
        Name        = "VM-NAT-${var.environment}"
        Environment = "${var.environment}"
    }
    root_block_device {
        volume_size           = 10
        volume_type           = "${local.volume_type}"
        delete_on_termination = true
    }
    network_interface {
        device_index         = 0
        network_interface_id = "${aws_network_interface.this.id}"
    }
}

resource "aws_security_group" "this" {
    name        = "SG-NAT-${var.environment}"
    description = "Security group VM-NAT"
    vpc_id      = "${aws_vpc.this.id}"
    tags {
        Name        = "SG-NAT-${var.environment}"
        Environment = "${var.environment}"
    }
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }
    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}