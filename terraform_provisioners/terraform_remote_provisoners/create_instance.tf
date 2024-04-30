provider "aws" {
  region = "ap-south-1"

}
resource "aws_instance" "myec2" {
  ami                    = "ami-006935d9a6773e4ec"
  instance_type          = "t2.micro"
  key_name               = "linux-41"
  vpc_security_group_ids = [aws_security_group.allow_ports.id]
  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y nginx1.12",
      "sudo systemctl start nginx"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("D:\\aws_keys\\linux-41.pem")
      host        = self.public_ip
    }
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.myec2.public_ip} >> public_ips.txt"
  }

}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "allow_ports" {
  name        = "allow_ports_ec21"
  description = "Allow inbound traffic"

  ingress {
    description = "http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ssh port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ports_ec21"
  }
}
