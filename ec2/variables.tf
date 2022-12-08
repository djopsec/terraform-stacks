variable "repo" {
  description = "GitHub repo"
  type        = string
  default     = "terraform-stacks"
}

variable "org" {
  description = "GitHub Organization"
  type        = string
  default     = "djopsec"
}

variable "ami" {
  description = "Amazon Linux 2 Kernel 5.10 AMI 2.0.20221103.3 x86_64 HVM gp2"
  type = string
  default = "ami-0b0dcb5067f052a63"
}