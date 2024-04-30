provider "aws" {
  region = "ap-south-1"
}
# This is a single-line comment.
resource "aws_instance" "base" {
  ami                    = "ami-0d13e3e640877b0b9"
  instance_type          = "t2.micro"
  count                  = 2
  key_name               = "linux-41"
  vpc_security_group_ids = [aws_security_group.allow_ports.id]
  user_data              = file("./init_script.sh")

  tags = {
    Name = "jmsth39_${count.index}"
  }
}
# resource "aws_eip" "myeip" {
#   count    = length(aws_instance.base)
#   vpc      = true
#   instance = element(aws_instance.base.*.id, count.index)
#
#   tags = {
#     Name = "jmsth34_${count.index + 1}"
#   }
# }


data "aws_vpc" "default" {
  default = true
}
resource "aws_security_group" "allow_ports" {
  name        = "alb"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.default.id
  ingress {
    description = "http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "http from VPC"
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
    Name = "allow_ports"
  }
}
#data "aws_subnet_ids" "subnet" {
#  vpc_id = aws_default_vpc.default.id
#}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}
resource "aws_lb_target_group" "my-target-group" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 2
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }

  name        = "my-test-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.default.id
}

resource "aws_lb" "my-aws-alb" {
  name     = "jmsth-test-alb"
  internal = false
  security_groups = [
    "${aws_security_group.allow_ports.id}",
  ]

  subnets = data.aws_subnet_ids.default.ids
  tags = {
    Name = "jmsth-test-alb"
  }

  ip_address_type    = "ipv4"
  load_balancer_type = "application"
}

resource "aws_lb_listener" "jmsth-test-alb-listner" {

  load_balancer_arn = aws_lb.my-aws-alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.my-target-group.arn
    type             = "forward"
  }
}
resource "aws_alb_target_group_attachment" "ec2_attach" {
  count            = length(aws_instance.base)
  target_group_arn = aws_lb_target_group.my-target-group.arn
  target_id        = aws_instance.base[count.index].id
}

output "mylb" {
  value = aws_lb.my-aws-alb.dns_name
}
