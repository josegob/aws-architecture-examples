#!/bin/bash
yum update -y
yum install -y httpd
yum install -y amazon-efs-utils
yum install -y jq
systemctl start httpd
systemctl enable httpd
mkdir /var/www/html/efs
REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq .region -r)
EFSID=$(aws ssm get-parameters --region $REGION --names /APP/EFS/APPEFSID --query Parameters[0].Value | sed -e 's/^"//' -e 's/"$//')
mount -t efs -o tls $EFSID:/ /var/www/html/efs
EC2_AVAIL_ZONE=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
echo "<h1>Hello World from $(hostname -f) in AZ $EC2_AVAIL_ZONE </h1><img src="efs/cats.jpg" width=500/>" > /var/www/html/index.html