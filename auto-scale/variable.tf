variable "no-of-instances" {
  default = 2
}
variable "region" {
  description = "AWS region for hosting our your network"
  default     = "ap-south-1"
}
variable "amiid" {
  description = "Base ami to launch the instances"
  default     = "ami-0d951b011aa0b2c19"
}
