resource "aws_security_group" "sg_cdh" {
  name = "sg_cdh"
  description = "Security group that is needed for the cdh servers"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.whitelisted_source}"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["${var.whitelisted_source}"]
  }

  ingress {
    from_port = 7180
    to_port = 7180
    protocol = "tcp"
    cidr_blocks = ["${var.whitelisted_source}"]
  }

  ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      self = "true"
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      self = "true"
  }


  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.project}-${var.environment}-sg_cdh"
    Environment = "${var.environment}"
    Project = "${var.project}"
  }
}
