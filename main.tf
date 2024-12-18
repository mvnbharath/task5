provider "aws" {
  region = "ap-south-1" 
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_security_group" "default" {
  filter {
    name   = "group-name"
    values = ["default"]
  }
}

resource "aws_instance" "amazon_linux" {
  ami                    = "ami-0614680123427b75e" 
  instance_type          = "t2.micro"             
  key_name               = "mumbai" 
  subnet_id              = data.aws_subnets.default.ids[0] 
  vpc_security_group_ids = [data.aws_security_group.default.id] 

  tags = {
    Name = "amazon_linux_vm"
  }

  
  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname c8.local
              echo "c8.local" > /etc/hostname
              EOF
}


resource "aws_instance" "ubuntu_2104" {
  ami                    = "ami-053b12d3152c0cc71" 
  instance_type          = "t2.micro"             
  key_name               = "mumbai" 
  subnet_id              = data.aws_subnets.default.ids[0] 
  vpc_security_group_ids = [data.aws_security_group.default.id] 

  tags = {
    Name = "ubuntu_21_04_vm"
  }

  
  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname u21.local
              echo "u21.local" > /etc/hostname
              EOF
}
