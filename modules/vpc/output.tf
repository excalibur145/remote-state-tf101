output "vpc-id" {
  value = aws_vpc.uj-vpc.id
}

output "sg" {
  value = aws_security_group.allow-web.id
}

output "key_name" {
  value = aws_instance.ubuntu.key_name
}