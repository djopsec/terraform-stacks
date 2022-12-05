# Terraform Stacks 

## Introduction

This repo demos a basic Terraform stack for an AWS account to show the capabilities of a modular IaC cloud implementation using terrafrom and terrafrom cloud.

Fundementally, it splits the terraform objects that are contain in a `tfstate` into multiples directories. These can be as granual as possible based on buissness need. 

It can reduce the amount of time needed to execute a terrafrom command againts an state given as each directory will have a workspace with a dedecated `tfstate` with less objects to process.

## Repo Structure

Each directory holds specific aws resources. The final `terraform apply` will generate a `tfstate` per directory. This cuts down on the number of repos that need to be managed. However, for sensitive resources that need to be further isolated can reside in there own dedicated repo.

```
.
├── README.md
├── endpoints
├── instances
├── security_groups
└── vpc
```

## Terrafrom Cloud Workspaces

The code is prepared to deploy via a dedicated Terraform Cloud workspaces per environment + service. This allows reuse of the same code in differents environments, but potentially with differents values.

The code integration with terrafrom cloud allows to inhert `terraform_remote_state` from one workspace to another as some will have dependencies due to the nature of the resources needed. 

For example, to create an ec2 instance it depends on vpc + sg resources. The instance layer will use variables from security group `tfstate` + vpc `tfstate`. 

There is an explicit permisson need it at terrafrom cloud UI level for `tfstate` sharing between worskpaces.

### Workspaces Naming Requirements

Workspaces should include the repo and directory in their name. Region can also be specified to reflect desired granuality. 


| Folder         | example workspace  |
|----------------|:--------------:|
|vpc             |demo-vpc       |
|security_groups |demo-sg		   |
|instances       |demo-instances |
|endpoints       |demo-endpoints |

## Access Control

Access can be managed at mutiple levels becoming more restrictive as it nears deployment. A single or mutiple repos can be used and access determined base on who needs what access to the code and repo. Then further granual permissions can be set in per workspace to protect deployments from unauthorized access. 
