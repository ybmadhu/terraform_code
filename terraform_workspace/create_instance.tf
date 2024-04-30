provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "myec2" {
  ami           = "ami-0d13e3e640877b0b9"
  instance_type = lookup(var.instance_type, terraform.workspace)
}

variable "instance_type" {
  type = map(string)

  default = {
    default = "t2.nano"
    dev     = "t2.micro"
    prd     = "t2.medium"
  }
}
