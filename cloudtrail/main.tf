terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "terraform-stacks-demo"

    workspaces {
      name = "demo-cloudtrail"
    }
  }
}

provider "aws" {
  region = local.region
}

locals {
  region                    = var.region
  trail_name                = var.trail_name
  cloudwatch_log_group_name = var.cloudwatch_log_group_name
  s3_key_prefix             = var.s3_key_prefix
  logs_bucket               = var.logs_bucket
  tags = {
    GithubRepo = "${var.repo}"
    GithubOrg  = "${var.org}"
  }
}

module "cloudtrail" {
  source  = "trussworks/cloudtrail/aws"
  version = "4.4.0"

  trail_name = local.trail_name

  cloudwatch_log_group_name = local.cloudwatch_log_group_name

  s3_bucket_name = module.logs.aws_logs_bucket
  s3_key_prefix  = local.s3_key_prefix
}

module "logs" {
  source  = "trussworks/logs/aws"
  version = "~> 12"

  s3_bucket_name = var.logs_bucket

  cloudtrail_logs_prefix = local.s3_key_prefix
  allow_cloudtrail       = true

  force_destroy = true
}