


terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta2"
    }
  }
  backend "s3" {
    bucket ="demo-bucket-78e64eb05d9b7e45"
    key = "backend.tfstate"
    region = "eu-north-1"
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "myserver" {
    ami = "ami-0c1ac8a41498c1a9c"
    instance_type = "t3.micro"

    subnet_id = "subnet-054d9e09652245afc"

    tags= {
        Name="SampleServer"
    }
  
}