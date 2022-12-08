data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "terraform-stacks-demo"
    workspaces = {
      name = "demo-vpc"
    }
  }
}

data "terraform_remote_state" "sg" {
  backend = "remote"

  config = {
    organization = "terraform-stacks-demo"
    workspaces = {
      name = "demo-sg"
    }
  }
}

terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "terraform-stacks-demo"

    workspaces {
      name = "demo-ec2"
    }
  }
}

provider "aws" {
  region = local.region
}

locals {
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  region = data.terraform_remote_state.vpc.outputs.vpc_region
  cidr   = data.terraform_remote_state.vpc.outputs.vpc_cidr

  tags = {
    Workspace  = "${terraform.workspace}"
    GithubRepo = "${var.repo}"
    GithubOrg  = "${var.org}"
  }
}