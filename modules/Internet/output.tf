output "nic" {
  value = aws_network_interface.nic-web.id
}

output "igw-id" {
  value = aws_internet_gateway.igw1.id
}