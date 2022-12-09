terraform {
  required_version = ">= 0.13.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.28"
    }
    tfvars = {
      source  = "innovationnorway/tfvars"
      version = "0.0.1"
    }
  }
}
