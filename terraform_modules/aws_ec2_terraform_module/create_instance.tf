provider "aws" {
  region = "ap-south-1"

}

module "ec2_cluster" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 4.0"

  name = "my-cluster"

  ami           = "ami-0d13e3e640877b0b9"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0a0bcc6fe4a66002b"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

