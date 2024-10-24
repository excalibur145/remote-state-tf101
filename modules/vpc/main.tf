
resource "aws_vpc" "uj-vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = "Production"
  }
}


#Security group
resource "aws_security_group" "allow-web" {
  name        = "web-traffic"
  description = "Allow web traffic and all outbound traffic"
  vpc_id      = aws_vpc.uj-vpc.id


  dynamic "ingress" {
    for_each = var.ingress-rules
    iterator = rule

    content {
      description = rule.value.description
      from_port   = rule.value.port
      to_port     = rule.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web"
  }
}


#Elastic ip - public ip
resource "aws_eip" "eip1" {
  domain                    = "vpc"
  network_interface         = var.nic-id
  associate_with_private_ip = "10.0.1.50"
  depends_on = [
    var.igw-id,
    aws_instance.ubuntu
  ]

}

resource "aws_instance" "ubuntu" {
 count = var.instance-count

  ami               = var.ec2_config.ami
  instance_type     = var.ec2_config.instance_type
  availability_zone = var.subnet_az
  key_name          = var.key-name

  network_interface {
    network_interface_id = var.nic-id
    device_index         = 0
  }

  user_data = var.user_data_script
  tags = {
    Name = "web-server  ${count.index}"
  }
}
