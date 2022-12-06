terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "terraform-stacks-demo"

    workspaces {
      name = "demo-vpc"
    }
  }
}

provider "aws" {
  region = "${local.region}"
}

locals {
  name   = "${var.vpc_name}"
  region = "${var.region}"
  cidr   = "${var.CIDR}"

  tags = {
    Workspace  = "${terraform.workspace}"
    GithubRepo = "${var.repo}"
    GithubOrg  = "${var.org}"
  }
}

################################################################################
# VPC Module
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"

  name = local.name
  cidr = "${local.cidr}.0.0/16"

  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  private_subnets = ["${local.cidr}.1.0/24", "${local.cidr}.2.0/24", "${local.cidr}.3.0/24"]
  public_subnets  = ["${local.cidr}.101.0/24", "${local.cidr}.102.0/24", "${local.cidr}.103.0/24"]

  enable_ipv6 = true

  enable_nat_gateway = false
  single_nat_gateway = true

  public_subnet_tags = {
    Name = "${local.name}"
  }

  tags = local.tags

  vpc_tags = {
    Name = "${local.name}"
  }
}
