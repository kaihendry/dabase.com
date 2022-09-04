---
title: Terraform a role
date: 2022-08-25
description: Why is this so hard?
---

Assuming var.gitlab_runner_role_arn has sts.assumerole privileges.

    resource "aws_iam_role" "gitlab_runner" {
      name               = "GitlabRunner"
      description        = "Gitlab role for read only access"
      assume_role_policy = data.aws_iam_policy_document.allow_central_access.json
    }

    resource "aws_iam_role_policy_attachment" "readonly" {
      role       = aws_iam_role.gitlab_runner.name
      policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
    }

    data "aws_iam_policy_document" "allow_central_access" {
      statement {
    	sid     = "gitlabrunner"
    	effect  = "Allow"
    	actions = ["sts:AssumeRole"]
    	principals {
    	  identifiers = [var.gitlab_runner_role_arn]
    	  type        = "AWS"
    	}
      }
    }
