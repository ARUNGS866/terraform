


terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta2"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "myserver" {
    ami = "ami-0c1ac8a41498c1a9c"
    instance_type = "t3.micro"

    subnet_id = "subnet-054d9e09652245afc"

    tags= {
        Name="SampleServer"
    }
  
}