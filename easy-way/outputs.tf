output "public_instance_public_ip" {
  description = "Public IP address of the public instance"
  value       = module.public_instance.this_ec2_instance_public_ip
}

output "private_instance_private_ip" {
  description = "Private IP address of the private instance"
  value       = module.private_instance.this_ec2_instance_private_ip
}

output "ssh_private_key_file" {
  description = "Local path to the generated SSH private key file"
  value       = local_file.ssh_private_key.filename
}
