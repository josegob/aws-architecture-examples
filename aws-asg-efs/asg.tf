resource "aws_autoscaling_group" "ec2_cat_asg" {
    name = "ec2-cats-asg"
    max_size = 4
    min_size = 2
    vpc_zone_identifier = [ for subnet in aws_subnet.pub : subnet.id ]
    launch_template {
      id = aws_launch_template.ec2_cats.id
      version = "$Latest"
    }
    health_check_type = "ELB"
    desired_capacity = 2
    target_group_arns = [ aws_lb_target_group.ec2_lb_tg.arn ]
}