resource "aws_iam_role" "ec2_role" {
    name = "EC2SSMRole"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Sid    = ""
            Principal = {
            Service = "ec2.amazonaws.com"
            }
        },
        ]
    })
    managed_policy_arns = var.iam_policy_arns
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "EC2SSMProfile"
  role = aws_iam_role.ec2_role.name
}