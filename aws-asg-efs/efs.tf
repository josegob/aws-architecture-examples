resource "aws_efs_file_system" "ec2_efs" {
    performance_mode = var.efs_performance_mode
    throughput_mode = var.efs_throughput_mode
    tags = {
        Name = "ec2-efs-system"
    }
}

resource "aws_efs_mount_target" "ec2_target" {
    file_system_id = aws_efs_file_system.ec2_efs.id
    count = length(var.private_az_names)
    subnet_id = aws_subnet.app[count.index].id
    security_groups = [ aws_security_group.app_sg.id ]
}