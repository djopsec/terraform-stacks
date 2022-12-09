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

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "logs_bucket" {
  type = string
  default = "djopsec-demo-cloudtrail-logs"
}

variable "s3_key_prefix" {
  type = string
  default = "cloudtrail"
}

variable "trail_name" {
  type = string
  default = "demo"
}

variable "cloudwatch_log_group_name" {
  type = string
  default = "demo"
}
