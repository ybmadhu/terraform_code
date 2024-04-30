provider "aws" {
  region = "ap-south-1"
}

locals {
  common_tags = {
    BU         = "infosys"
    CostGroup1 = "jmsth"
    CostGroup2 = "ec2-servers"
  }
}

resource "aws_instance" "dev" {
  ami           = "ami-0d13e3e640877b0b9"
  instance_type = "t2.micro"
  tags          = local.common_tags
}
resource "aws_instance" "stagging" {
  ami           = "ami-0d13e3e640877b0b9"
  instance_type = "t2.nano"
  tags          = local.common_tags
}
