/* variable "repo" {
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

variable "s3_list" {
  description = "S3 Buckets List"
  type        = map(object({ purpose = string }))
  default = {
    "s3-demo" = {
      "purpose" = "demo"
    }
  }
} */