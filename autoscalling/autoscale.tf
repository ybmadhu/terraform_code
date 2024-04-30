provider "aws" {
  region = var.region # Set your desired AWS region
}
data "aws_vpc" "default" {
  default = true
}
data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
resource "aws_security_group" "web_sg" {
  name_prefix = "web-sg-"

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

resource "aws_launch_template" "web_lt" {
  name_prefix   = "web-lt-"
  image_id      = var.amiid
  instance_type = "t2.micro"
  user_data     = filebase64("init_script.sh")

  key_name = "linux-41"
}

resource "aws_autoscaling_group" "web_asg" {
  name = "web-asg"
  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }
  min_size         = 2
  max_size         = 2
  desired_capacity = 2

  health_check_type         = "EC2"
  health_check_grace_period = 60 # 5 minutes
  availability_zones        = ["ap-south-1a", "ap-south-1b"]

  target_group_arns = [aws_lb_target_group.web_target_group.arn]

  tag {
    key                 = "Name"
    value               = "WebInstance"
    propagate_at_launch = true
  }
}

resource "aws_lb" "web_lb" {
  name               = "web-lb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.web_sg.id]

  subnets = data.aws_subnets.default_subnets.ids

  enable_deletion_protection = false
}



resource "aws_lb_target_group" "web_target_group" {
  name     = "web-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id
}

output "load_balancer_dns" {
  value = aws_lb.web_lb.dns_name
}
