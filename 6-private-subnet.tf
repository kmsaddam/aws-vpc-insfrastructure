resource "aws_subnet" "private_zone1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.64.0/19"
    availability_zone = "us-east-2a"

    tags = {
      "Name" = "dev-private-us-east-2a" 
    }
}