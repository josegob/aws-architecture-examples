resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags = {
      Name = var.vpc_name
  }
}

resource "aws_subnet" "pub" {
    vpc_id = aws_vpc.main.id
    count = length(var.public_az_names)
    cidr_block = "10.16.${0 + count.index}.0/24"
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.available.names[count.index]
    tags = {
        Name = var.public_az_names[count.index]
    }
}

resource "aws_subnet" "app" {
    vpc_id = aws_vpc.main.id
    count = length(var.private_az_names)
    cidr_block = "10.16.${10 + count.index}.0/24"
    availability_zone = data.aws_availability_zones.available.names[count.index]
    tags = {
        Name = var.private_az_names[count.index]
    }
}

data "aws_availability_zones" "available" {
  state = "available"
}