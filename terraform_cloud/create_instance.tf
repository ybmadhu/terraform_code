provider "aws" {
  region = "ap-south-1"

}

terraform {
  cloud {
    organization = "jmstechhome62"

    workspaces {
      name = "test"
    }
  }
}
resource "aws_instance" "myec2" {
  ami           = "ami-0d13e3e640877b0b9"
  instance_type = "t2.nano"
}

