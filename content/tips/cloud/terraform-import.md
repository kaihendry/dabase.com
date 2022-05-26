---
title: Terraform Import
date: 2022-05-26
description: Managing a VPC in Terraform
---

Following https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc

    terraform import aws_vpc.def_vpc vpc-0319cd6f0f0063cef
    Error: resource address "aws_vpc.def_vpc" does not exist in the configuration.

    Before importing this resource, please create its configuration in the root module. For example:

    resource "aws_vpc" "def_vpc" {
      # (resource arguments)
    }

Appended to main.tf

    resource "aws_vpc" "def_vpc" {
      # (resource arguments)
    }

Now import again:

    $ terraform import aws_vpc.def_vpc vpc-0319cd6f0f0063cef
    aws_vpc.def_vpc: Importing from ID "vpc-0319cd6f0f0063cef"...
    aws_vpc.def_vpc: Import prepared!
      Prepared aws_vpc for import
    aws_vpc.def_vpc: Refreshing state... [id=vpc-0319cd6f0f0063cef]

    Import successful!

    The resources that were imported are shown above. These resources are now in
    your Terraform state and will henceforth be managed by Terraform.

But no details of the VPC?

However when I destroy, I now see the defaults:

    $ terraform destroy
    aws_vpc.def_vpc: Refreshing state... [id=vpc-0319cd6f0f0063cef]

    Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
      - destroy

    Terraform will perform the following actions:

      # aws_vpc.def_vpc will be destroyed
      - resource "aws_vpc" "def_vpc" {
    	  - arn                              = "arn:aws:ec2:ap-southeast-1:830993565621:vpc/vpc-0319cd6f0f0063cef" -> null
    	  - assign_generated_ipv6_cidr_block = false -> null
    	  - cidr_block                       = "172.31.0.0/16" -> null
    	  - default_network_acl_id           = "acl-0ab4ad2909d47724d" -> null
    	  - default_route_table_id           = "rtb-0f16e3a4242ad1384" -> null
    	  - default_security_group_id        = "sg-0e3d60ada608d798d" -> null
    	  - dhcp_options_id                  = "dopt-04c5af49bd0761684" -> null
    	  - enable_classiclink               = false -> null
    	  - enable_classiclink_dns_support   = false -> null
    	  - enable_dns_hostnames             = true -> null
    	  - enable_dns_support               = true -> null
    	  - id                               = "vpc-0319cd6f0f0063cef" -> null
    	  - instance_tenancy                 = "default" -> null
    	  - ipv6_netmask_length              = 0 -> null
    	  - main_route_table_id              = "rtb-0f16e3a4242ad1384" -> null
    	  - owner_id                         = "830993565621" -> null
    	  - tags                             = {} -> null
    	  - tags_all                         = {} -> null
    	}

    Plan: 0 to add, 0 to change, 1 to destroy.

    Do you really want to destroy all resources?
      Terraform will destroy all your managed infrastructure, as shown above.
      There is no undo. Only 'yes' will be accepted to confirm.

    Enter a value: yes

    aws_vpc.def_vpc: Destroying... [id=vpc-0319cd6f0f0063cef]
    aws_vpc.def_vpc: Still destroying... [id=vpc-0319cd6f0f0063cef, 10s elapsed]
    aws_vpc.def_vpc: Still destroying... [id=vpc-0319cd6f0f0063cef, 20s elapsed]
    aws_vpc.def_vpc: Still destroying... [id=vpc-0319cd6f0f0063cef, 30s elapsed]
    aws_vpc.def_vpc: Still destroying... [id=vpc-0319cd6f0f0063cef, 4m20s elapsed]
    aws_vpc.def_vpc: Still destroying... [id=vpc-0319cd6f0f0063cef, 4m30s elapsed]
    aws_vpc.def_vpc: Still destroying... [id=vpc-0319cd6f0f0063cef, 4m40s elapsed]
    aws_vpc.def_vpc: Still destroying... [id=vpc-0319cd6f0f0063cef, 4m50s elapsed]
    ╷
    │ Error: error deleting EC2 VPC (vpc-0319cd6f0f0063cef): DependencyViolation: The vpc 'vpc-0319cd6f0f0063cef' has dependencies and cannot be deleted.
    │       status code: 400, request id: 818406c1-3af6-4fe4-a187-2b0737680bfc

Begs the question, how do people start AWS account networking from scratch?
