terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "terraform-stacks-demo"

    workspaces {
      name = "demo-s3"
    }
  }
}

provider "aws" {
  region = local.region
}

# provider "tfvars" {}

# data "tfvars_file" "s3" {
#   filename = "s3_buckets.auto.tfvars"
# }

 locals {
   region = var.region

   tags = {
     GithubRepo = "${var.repo}"
     GithubOrg  = "${var.org}"
   }
 } 