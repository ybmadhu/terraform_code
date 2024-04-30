
variable "ami" {
  type = map(any)
  default = {
    "us-east-1"  = "ami-0947d2ba12ee1ff75"
    "ap-south-1" = "ami-0d13e3e640877b0b9"
  }
}
variable "region" {
  default = "ap-south-1"
}
variable "tags" {
  type    = list(any)
  default = ["firstec2", "secondec2"]
}