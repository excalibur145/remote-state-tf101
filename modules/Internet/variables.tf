variable "vpc-id"{
  type=string

}

variable "subnet-cidr" {
  type= string
  default = "10.0.0.0/16"
}

variable "subnet_az" {
  type = string
  default = "us-east-1a"
}

variable "sg-id" {
  type = string
}