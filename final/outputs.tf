output "public_ec2_ip" {
  value = aws_instance.public_ec2.public_ip
}

output "private_ec2_ip" {
  value = aws_instance.private_ec2.private_ip
}

output "bastion_ip" {
  value = aws_instance.bastion.public_ip
}

output "ansible_key_file" {
  value = "${path.module}/ansible_key.pem"
}
