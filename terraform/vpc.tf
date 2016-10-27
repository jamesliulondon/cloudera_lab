# Creat a VPC
resource "aws_vpc" main {
    cidr_block = "${var.cidr_block}"
    enable_dns_support = true
    enable_dns_hostnames = true

tags {
    Name = "${var.project} VPC"
    Environment = "${var.environment}"
    Project = "${var.project}"
  }
}

