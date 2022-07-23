resource "aws_lb_target_group" "ec2_lb_tg" {
    name = "ec2-cats-lb-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.main.id
    target_type = "instance"
    health_check {
      enabled = true
      healthy_threshold = 2
      interval = 30
      path = "/"
      port = "traffic-port"
    }
}

resource "aws_lb" "ec2_lb" {
    name = "ec2-cats-lb"
    internal = false
    load_balancer_type = "application"
    security_groups = [ aws_security_group.lb_sg.id ]
    subnets = [ for subnet in aws_subnet.pub : subnet.id ]
}

resource "aws_lb_listener" "ec2_lb_listener" {
    load_balancer_arn = aws_lb.ec2_lb.arn
    port = "80"
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.ec2_lb_tg.arn
    }
}