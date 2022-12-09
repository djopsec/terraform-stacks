# Terraform Stacks 

## Introduction

This repo demos a basic Terraform stack for an AWS account to show the capabilities of a modular IaC cloud implementation using Terraform and Terraform Cloud.

Fundamentally, it splits the Terraform objects that are contained in a `tfstate` into multiple directories. These can be as granular as possible based on business needs. 

It can reduce the amount of time needed to execute a Terraform command against a state given as each directory will have a workspace with a dedicated `tfstate` with less objects to process.

## Repo Structure

Each directory holds specific aws resources. The final `Terraform apply` will generate a `tfstate` per directory. This cuts down on the number of repos that need to be managed. However, sensitive resources that need to be further isolated can reside in their own dedicated repo.

```
.
├── README.md
├── endpoints
├── instances
├── security_groups
└── vpc
```

## Terraform Cloud Workspaces

The code is prepared to deploy via a dedicated Terraform Cloud workspaces per environment + service. This allows reuse of the same code in different environments, but potentially with different values.

The code integration with Terraform cloud allows to inherit `Terraform_remote_state` from one workspace to another as some will have dependencies due to the nature of the resources needed. 

For example, to create an ec2 instance it depends on vpc + sg resources. The instance layer will use variables from security group `tfstate` + vpc `tfstate`. 

There is an explicit permission needed at Terraform Cloud UI level for `tfstate` sharing between workspaces.

### Workspaces Naming Requirements

Workspaces should include the repo and directory in their name. Region can also be specified to reflect desired granularity. 


| Folder         | example workspace  |
|----------------|:--------------:|
|vpc             |demo-vpc       |
|security_groups |demo-sg		   |
|instances       |demo-instances |
|endpoints       |demo-endpoints |

## Access Control

Access can be managed at multiple levels becoming more restrictive as it nears deployment. A single or multiple repos can be used and access determined based on who needs what access to the code and repo. Then further granular permissions can be set in per workspace to protect deployments from unauthorized access. 


