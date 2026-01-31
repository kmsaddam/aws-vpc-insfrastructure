variable "aws_region" {
  description = "The AWS region to deploy resources in (e.g., us-east-1 for N. Virginia/Boston area)"
  default     = "us-east-1"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instances (must be compatible with the region)"
  # This example uses a common Ubuntu AMI ID for us-east-1.
  # You might need to update this value if the AMI is deprecated or for a different OS.
  default     = "ami-0c7217cd2ae3d5501" 
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  default     = "t3.micro"
}

variable "public_key_path" {
  description = "The path to the SSH public key file for connecting to instances"
  default     = "~/.ssh/id_rsa.pub"
}
