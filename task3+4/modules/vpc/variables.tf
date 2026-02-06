variable "vpc_cidr" {
  type = string
}

variable "subnet_count" {
  type = number
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidr" {
  type = string
}
