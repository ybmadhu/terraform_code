provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket         = "jmsth40-statefile"
    key            = "ec2_2.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "statefile_store"
  }
}
resource "aws_instance" "myec2instance" {
  ami           = "ami-0d13e3e640877b0b9"
  instance_type = "t2.micro"
}


