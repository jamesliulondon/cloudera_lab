# Create internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "${var.project}  internet gateway"
    Environment = "${var.environment}"
    Project = "${var.project}"
  }
}

# Create public route table
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "${var.project} public route table"
    Environment = "${var.environment}"
    Project = "${var.project}"
  }
}

# Associate route table to public subnets
resource "aws_route_table_association" "public_hosts" {
  count = "${var.number_of_azs}"
  subnet_id = "${element(aws_subnet.public_subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

# Associate route table to private subnets
resource "aws_route_table_association" "private_hosts" {
  count = "${var.number_of_azs}"
  subnet_id = "${element(aws_subnet.private_subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}
