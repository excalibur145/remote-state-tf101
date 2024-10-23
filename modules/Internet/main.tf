
#internet gateway
resource "aws_internet_gateway" "igw1" {
  vpc_id = var.vpc-id
}


#route-table

resource "aws_route_table" "Prod-route-table" {
  vpc_id = var.vpc-id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
  }

  tags = {
    Name = "Prod"
  }
}


resource "aws_subnet" "Subnet-1" {
  vpc_id            = var.vpc-id
  cidr_block        = var.subnet-cidr
  availability_zone = var.subnet_az
  tags = {
    Name = "Prod-subnet"
  }
}


resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.Subnet-1.id
  route_table_id = aws_route_table.Prod-route-table.id
}


#network interface - creating the private ip for the host
resource "aws_network_interface" "nic-web" {
  subnet_id       = aws_subnet.Subnet-1.id
  private_ips     = ["10.0.1.50"]
  security_groups = [var.sg-id]

}
