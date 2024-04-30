variable "instancename" {
  type    = list(any)
  default = ["dev", "staging"]
}

variable "instance_type" {
  type    = list(any)
  default = ["t2.micro", "t2.medium"]
}
