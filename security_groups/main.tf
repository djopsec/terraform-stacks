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
  region = data.terraform_remote_state.vpc.outputs.vpc_region
  cidr   = data.terraform_remote_state.vpc.outputs.vpc_cidr

  tags = {
    Workspace  = "${terraform.workspace}"
    GithubRepo = "${var.repo}"
    GithubOrg  = "${var.org}"
  }
}

resource "aws_security_group" "public_https" {
  name        = "public_https"
  description = "Allow HTTPS inbound traffic for public subnets"
  vpc_id      = local.vpc_id

  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}