
provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "myec2" {
  ami                    = "ami-0ded8326293d3201b"
  instance_type          = "t2.medium"
  vpc_security_group_ids = ["sg-0b2b598dcc36d4733"]
  key_name               = "test-ansi"
  subnet_id              = "subnet-0a0bcc6fe4a66002b"
  tags = {
    Name = "testing"
  }
}

