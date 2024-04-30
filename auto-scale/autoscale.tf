provider "aws" {
  region = var.region
}

terraform {
  required_version = "> 1.0"
  required_providers {
    aws = "~> 4.0"
  }
}

data "aws_availability_zones" "all" {}

resource "aws_security_group" "instance" {
  name = "terraform-instance"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
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

}
## Creating Launch Configuration
resource "aws_launch_configuration" "example" {
  image_id        = var.amiid
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.instance.id}"]
  # key_name        = "jmsth38"
  user_data = file("./init_script.sh")
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

data "aws_subnet_ids" "subnet" {
  vpc_id = aws_default_vpc.default.id

}
## Creating AutoScaling Group
resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.id
  availability_zones   = ["ap-south-1a"]
  min_size             = 2
  max_size             = 10
  load_balancers       = ["${aws_elb.example.name}"]
  health_check_type    = "ELB"
  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }
}
## Security Group for ELB
resource "aws_security_group" "elb" {
  name = "terraform-example-elb"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
### Creating ELB
resource "aws_elb" "example" {
  name            = "terraform-asg-example"
  security_groups = ["${aws_security_group.elb.id}"]
  subnets         = data.aws_subnet_ids.subnet.ids
  health_check {
    healthy_threshold   = 10
    unhealthy_threshold = 10
    timeout             = 3
    interval            = 10
    target              = "HTTP:80/"
  }
  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "80"
    instance_protocol = "http"
  }
}
output "mylb" {
  value = aws_elb.example.dns_name
}
