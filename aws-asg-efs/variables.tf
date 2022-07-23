variable "vpc_name" {
    default = "Main"
    type = string
}

variable "vpc_cidr" {
    default = "10.16.0.0/16"
    type = string
}

variable "igw_name" {
    default = "IGW-main"
    type = string
}

variable "public_az_names" {
    default = [
        "PUB-A",
        "PUB-B"
    ]
    type = list(string)
}

variable "private_az_names" {
    default = [
        "APP-A",
        "APP-B"
    ]
    type = list(string)
}

variable "ec2_ssh_key_size" {
    default = "4096"
    type = string
}

variable "ec2_ssh_key_algorithm" {
    default = "RSA"
    type = string
}

variable "ec2_ami_id" {
    default = "ami-0cff7528ff583bf9a"
    type = string
}

variable "efs_performance_mode" {
    default = "generalPurpose"
    type = string
}

variable "efs_throughput_mode" {
    default = "bursting"
    type = string
}

variable "iam_policy_arns" {
    default = [
        "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess",
        "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    ]
}