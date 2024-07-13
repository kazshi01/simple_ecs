data "aws_vpc" "default" {
  filter {
    name   = "tag:Name"
    values = ["default-vpc"]
  }
}

data "aws_subnet" "default_public_subnet_a" {
  filter {
    name   = "tag:Name"
    values = ["default-a"]
  }
  vpc_id = data.aws_vpc.default.id
}

data "aws_subnet" "default_public_subnet_c" {
  filter {
    name   = "tag:Name"
    values = ["default-c"]
  }
  vpc_id = data.aws_vpc.default.id
}

data "aws_security_group" "default_web_sg" {
  filter {
    name   = "tag:Name"
    values = ["default-sg"]
  }
}
