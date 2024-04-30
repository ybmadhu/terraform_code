provider "aws" {
  region = "ap-south-1"
}
data "aws_ami" "my_ami" {
  most_recent = true
  owners      = ["amazon"]


  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.my_ami.id
  instance_type = "t2.micro"
}

output "myami" {
  value = data.aws_ami.my_ami.id
}