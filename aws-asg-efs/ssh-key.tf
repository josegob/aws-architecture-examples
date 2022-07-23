resource "tls_private_key" "ec2_ssh_key_pair" {
  algorithm = var.ec2_ssh_key_algorithm
  rsa_bits = var.ec2_ssh_key_size
}