variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

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
