---
title: No pagination with the AWS CLI
date: 2024-10-17
description: How do you get all the results from an AWS CLI query without pagination?
---

    ❯ aws --version
    aws-cli/2.17.64 Python/3.12.6 Darwin/23.6.0 source/arm64

Since there is no V2 of https://docs.aws.amazon.com/cli/v1/userguide/cli-usage-pagination.html ... here's the missing guide and example:

    ❯ cat engine_types.sh
    #!/bin/bash

    # Initialize the starting token as empty
    next_token=""

    # Loop until there's no NextToken
    while true; do
        if [ -z "$next_token" ]; then
            # Get the first page of results
            result=$(aws rds describe-db-instances --output json)
        else
            # Get the next page using the starting token
            result=$(aws rds describe-db-instances --starting-token "$next_token" --output json)
        fi

        # Extract the desired fields and print them as CSV
        echo "$result" | jq -r '.DBInstances[] | [.DBInstanceIdentifier, .Engine] | @csv'

        # Get the NextToken from the result
        next_token=$(echo "$result" | jq -r '.NextToken')

        # If there's no NextToken, break the loop
        if [ "$next_token" == "null" ]; then
            break
        fi
    done

Note you can't use `--query` as that will exclude the NextToken, hence you need to rely on `jq` to extract the fields you want.