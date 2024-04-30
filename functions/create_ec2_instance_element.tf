provider "aws" {
  region = "ap-south-1"
}

variable "region" {
  default = "ap-south-1"
}

variable "tags" {
  type    = list(any)
  default = ["firstec2", "secondec2"]
}
variable "ami" {
  type = map(any)
  default = {
    "us-east-1"  = "ami-0947d2ba12ee1ff75"
    "ap-south-1" = "ami-0d13e3e640877b0b9"
  }
}

locals {
  time = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
}

resource "aws_key_pair" "my_key" {
  key_name   = "jmsth39-40"
  public_key = file("${path.module}/jmsth39-40.pub")
}

resource "aws_instance" "stagging" {
  ami           = lookup(var.ami, var.region)
  instance_type = "t2.nano"
  key_name      = aws_key_pair.my_key.key_name
  count         = 2
  tags = {
    Name = element(var.tags, count.index)
  }
}

output "timestamp" {
  value = local.time
}
