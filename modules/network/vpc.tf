# ------------------------------------------------------------------------------
# CONFIGURE OUR NETWORK
# ------------------------------------------------------------------------------

resource "aws_vpc" "vpc_main" {
  cidr_block = 10.1.1.0/16
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name = "vpc_main"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  tags {
    Name = "igw"
  }
}
