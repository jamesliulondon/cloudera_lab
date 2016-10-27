resource "aws_subnet" "public_subnets" {
  count             = "${var.number_of_azs}"
  map_public_ip_on_launch = true
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${lookup(var.cidr_allocation_subnets, "public${(count.index + 1)%3}")}"
  availability_zone = "${lookup(var.availability_zones, "az${(count.index + 1)%3}")}"
  tags {
    Name = "public ${count.index + 1}"
    Environment = "${var.environment}"
    Project = "${var.project}"
  }
}

resource "aws_subnet" "private_subnets" {
  count             = "${var.number_of_azs}"
  map_public_ip_on_launch = true
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${lookup(var.cidr_allocation_subnets, "private${(count.index + 1)%3}")}"
  availability_zone = "${lookup(var.availability_zones, "az${(count.index + 1)%3}")}"
  tags {
    Name = "private ${count.index + 1}"
    Environment = "${var.environment}"
    Project = "${var.project}"
  }
}
