resource "aws_ssm_parameter" "efs_dns" {
    name = "/APP/EFS/APPEFSID"
    type = "String"
    value = aws_efs_file_system.ec2_efs.dns_name
}