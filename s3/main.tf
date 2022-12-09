data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "terraform-stacks-demo"
    workspaces = {
      name = "demo-vpc"
    }
  }
}

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

provider "tfvars" {}

locals {
  vpc_id          = data.terraform_remote_state.vpc.outputs.vpc_id
  region          = data.terraform_remote_state.vpc.outputs.vpc_region
  
  tags = {
    Workspace  = "${terraform.workspace}"
    GithubRepo = "${var.repo}"
    GithubOrg  = "${var.org}"
  }
}