variable "username" {
  type = string
}

variable "elb_name" {
  type = string
}
variable "az" {
  type = list(any)
}
variable "timeout" {
  type = number
}

variable "instance" {
  type = map(any)
}

variable "instance2" {
  type = list(any)
}
