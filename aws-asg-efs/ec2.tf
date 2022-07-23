resource "aws_key_pair" "ec2_key" {
  key_name   = "ec2-key"
  public_key = tls_private_key.ec2_ssh_key_pair.public_key_openssh
}

resource "aws_launch_template" "ec2_cats" {
  name = "ec2-cats"
  block_device_mappings {
    device_name ="/dev/xvda"
    ebs {
      volume_size = 8
      delete_on_termination = true
      volume_type = "gp2"
    }
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }
  image_id = var.ec2_ami_id
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.ec2_key.key_name}"
  vpc_security_group_ids = [ aws_security_group.pub_sg.id ]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "CatVM"
    }
  }
  user_data = "${filebase64("init.sh")}"
}