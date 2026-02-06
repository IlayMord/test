variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_az" {
  type    = string
  default = "us-east-1a"
}

variable "key_name" {
  type        = string
  default     = "ilay-private-key"

}

variable "allowed_ssh_cidrs" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
