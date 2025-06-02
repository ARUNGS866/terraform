
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta2"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "my_vpc"
    }  
}  

  resource "aws_subnet" "private-subnet" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.my_vpc.id
    tags ={
        Name = "private-subnet"
    }
    }

    resource "aws_subnet" "public-subnet" {
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.my_vpc.id
    tags ={
        Name = "public-subnet"
    }
    }

    resource "aws_internet_gateway" "my-igw" {
        vpc_id = aws_vpc.my_vpc.id
        tags ={
            Name = "my-igw"
        }
    }

    resource "aws_route_table" "my-rt" {
        vpc_id = aws_vpc.my_vpc.id

        route {
            cidr_block = "0.0.0.0/0"
            gateway_id = aws_internet_gateway.my-igw.id
        }
    }

    resource "aws_route_table_association" "public-sub" {
        route_table_id = aws_route_table.my-rt.id
        subnet_id = aws_subnet.public-subnet.id
      
    }
    resource "aws_instance" "myserver" {
    ami = "ami-0c1ac8a41498c1a9c"
    instance_type = "t3.micro"

    subnet_id = aws_subnet.public-subnet.id

    tags= {
        Name="SampleServer"
    }
  
}