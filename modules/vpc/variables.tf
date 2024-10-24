variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "nic-id" {
  type = string
}

variable "igw-id" {
  type = string
}


variable "subnet_az" {
  type    = string
  default = "us-east-1a"
}


variable "ec2_config" {
  description = "EC2 instance config type and ami"
  type = object({
    instance_type = string
    ami           = string
  })
  default = {
    instance_type = "t2.micro"
    ami           = "ami-0866a3c8686eaeeba" # Default Ubuntu AMI in us-east-1
  }
}

variable "user_data_script" {
  description = "Path to the user data script"
  type        = string
}

variable "key-name" {
  description = "add the name of your ppk key"
  type        = string
}


variable "ingress-rules" {
  description = "add your ingress rules port and description"
  type= list(object({
    port = number
    description = string
  }))

  default = [
    {
      port        = 22
      description = "SSH"
    },
    {
      port        = 80
      description = "HTTP"
    },
    {
      port        = 443
      description = "HTTPS"
    }
  ]
}

variable "instance-count" {
  description = "number of instances"
  type = number
  default = 1
}