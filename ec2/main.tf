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
  vpc_id          = data.terraform_remote_state.vpc.outputs.vpc_id
  region          = data.terraform_remote_state.vpc.outputs.vpc_region
  private_sg      = [data.terraform_remote_state.sg.outputs.all_private_security_group_id]
  private_subnets = data.terraform_remote_state.vpc.outputs.private_subnets[0]

  tags = {
    GithubRepo = "${var.repo}"
    GithubOrg  = "${var.org}"
  }
}