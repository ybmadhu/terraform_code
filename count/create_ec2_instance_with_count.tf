provider "aws" {
  region = "ap-south-1"
}
resource "aws_instance" "web" {
  ami = "ami-0d13e3e640877b0b9"
  # instance_type = "t2.micro"
  instance_type = var.instance_type[count.index]
  count         = 2
  tags = {
    # Name = "server_${count.index}"
    Name = var.instancename[count.index]
  }
}
