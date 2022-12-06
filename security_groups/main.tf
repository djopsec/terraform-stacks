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
      name = "demo-sg"
    }
  }
}

provider "aws" {
  region = local.region
}

locals {
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  region = var.region
  cidr   = data.terraform_remote_state.vpc.outputs.vpc_cidr_block

  tags = {
    Workspace  = "${terraform.workspace}"
    GithubRepo = "${var.repo}"
    GithubOrg  = "${var.org}"
  }
}