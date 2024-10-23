# For VPC
We need to specify CIDR block, nic-id and internet gateway id reference (from internet module),
subnet availibility zone, and ec2 instance config, key-name and user-script

# For Internet
We need to specify vpc id reference, subnet cidr, subnet availibility zone and security group id (from vpc module)


example: --> 

```
# Declare VPC module
module "vpc" {
  source    = "git::https://github.com/excalibur145/remote-state-tf101.git//modules/vpc?ref=master"
  cidr_block = "10.0.0.0/16"
  
  nic-id     = module.internet.nic
  igw-id     = module.internet.igw-id
  key-name   = "Terraform-test-key"
  subnet_az        = "us-east-1a"  
  ec2_config = {
        ami = "ami-0866a3c8686eaeeba"
        instance_type = "t2.micro"
    }
    user_data_script = file("web.sh")
}


module "internet" {
  source        = "git::https://github.com/excalibur145/remote-state-tf101.git//modules/Internet?ref=master"
  vpc-id        = module.vpc.vpc-id
  subnet-cidr   = "10.0.1.0/24" 
  subnet_az     = "us-east-1a"    
  sg-id         = module.vpc.sg  
}
```


# for web.sh 
you can give a shell script for initial commands that instance needs to run, also you can give any name you want, give that name when calling user_data_script in vpc module
example script for web.sh: 

```
#!/bin/bash

sudo apt-get update
sudo apt update -y
sudo ufw disable
sudo apt install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2
echo "my first web server with terraform" | sudo tee /var/www/html/index.html > /dev/null
sudo systemctl restart apache2
sudo systemctl status apache2

```