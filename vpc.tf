resource "aws_vpc" "yogesh-demo" {
    cidr_block = "${var.vpc_cidr}"
   # enable_dns_hostnames = true
    tags {
        Name = "terraform-aws-vpc"
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.yogesh-demo.id}"
}

#Public Subnet
resource "aws_subnet" "us-east-1a-public" {
    vpc_id = "${aws_vpc.yogesh-demo.id}"

    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "us-east-2b"

    tags {
        Name = "Public Subnet"
    }
}
resource "aws_subnet" "us-east-2c-public" {
    vpc_id = "${aws_vpc.yogesh-demo.id}"

    cidr_block = "${var.private_subnet_cidr}"
    availability_zone = "us-east-2c"

    tags {
        Name = "Public Subnet"
    }
}


#route table
resource "aws_route_table" "us-east-1a-public" {
    vpc_id = "${aws_vpc.yogesh-demo.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags {
        Name = "Public Subnet"
    }
}

resource "aws_route_table_association" "us-east-1a-public" {
    subnet_id = "${aws_subnet.us-east-1a-public.id}"
    route_table_id = "${aws_route_table.us-east-1a-public.id}"
}


