provider "aws" {
  region = var.aws_region
}

# Generate a key pair for SSH access
resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "ec2-boston-key"
  public_key = tls_private_key.pk.public_key_openssh
}

resource "local_file" "ssh_private_key" {
  content  = tls_private_key.pk.private_key_pem
  filename = "ec2-boston-key.pem"
  file_permission = "0400" # Set correct permissions for SSH key
}


# Use the terraform-aws-modules/vpc module for simplicity and best practices
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.1.0"

  name = "boston-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway = true
  enable_internet_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "Boston"
  }
}

# Use the terraform-aws-modules/ec2-instance module to create instances
# Public (Bastion) Host
module "public_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "4.2.0"

  name = "public-bastion-host"
  ami = var.ami_id
  instance_type = var.instance_type
  key_name = aws_key_pair.kp.key_name
  subnet_id = module.vpc.public_subnets[0] # Place in the first public subnet

  vpc_security_group_ids = [module.vpc.default_security_group_id]
  associate_public_ip_address = true # Automatically assign a public IP

  tags = {
    Name = "PublicBastionHost"
  }
}

# Private Host
module "private_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "4.2.0"

  name = "private-app-server"
  ami = var.ami_id
  instance_type = var.instance_type
  key_name = aws_key_pair.kp.key_name
  subnet_id = module.vpc.private_subnets[0] # Place in the first private subnet

  vpc_security_group_ids = [module.vpc.default_security_group_id]
  associate_public_ip_address = false # Do not assign a public IP

  tags = {
    Name = "PrivateAppServer"
  }
}
