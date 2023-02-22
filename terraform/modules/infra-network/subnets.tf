data "aws_vpc" "default"{
  default = true
}

resource "aws_subnet" "public-1a" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "172.31.64.0/20"
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "public-1a"
  }
}
resource "aws_subnet" "public-1b" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "172.31.96.0/20"
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "public-1b"
  }
}
resource "aws_subnet" "public-1c" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "172.31.128.0/20"
  availability_zone = "${var.aws_region}c"

  tags = {
    Name = "public-1c"
  }
}