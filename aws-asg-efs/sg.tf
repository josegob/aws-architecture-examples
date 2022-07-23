resource "aws_security_group" "pub_sg" {
    name = "pub sg ec2"
    description = "SG used for PUB instances"
    vpc_id = aws_vpc.main.id
    ingress {
        description = "HTTP from LB"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = [ aws_security_group.lb_sg.id ]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    tags = {
        Name = "Public SG EC2"
    }
}

resource "aws_security_group" "app_sg" {
    name = "app sg efs"
    description = "SG used for EFS system"
    vpc_id = aws_vpc.main.id
    ingress {
        description = "EFS from PUB SG"
        from_port = 2049
        to_port = 2049
        protocol = "tcp"
        security_groups = [ aws_security_group.pub_sg.id ]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    tags = {
        Name = "APP SG EC2"
    }
}

resource "aws_security_group" "lb_sg" {
    name = "pub sg lb"
    description = "SG used for LB"
    vpc_id = aws_vpc.main.id
    ingress {
        description = "HTTP from outside"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    tags = {
        Name = "Public SG for LB"
    }
}