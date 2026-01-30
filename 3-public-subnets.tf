resource "aws_subnet" "public_zone1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.0.0/19"
    availability_zone = "us-east-2a"
    map_public_ip_on_launch = true

    tags = {
      "Name" = "dev-public-us-east-2a" 
    }
}