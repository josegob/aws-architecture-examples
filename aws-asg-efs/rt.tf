resource "aws_route_table" "pub" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id
    }
}

resource "aws_route_table_association" "rta_pub" {
    count = length(var.public_az_names)
    subnet_id = aws_subnet.pub[count.index].id
    route_table_id = aws_route_table.pub.id
}