---
title: Amazon Certificate Manager Pro Tip
date: 2020-12-03T11:11:38+08:00
description: Avoid email validation and use DNS Validation Method and wildcards for sanity reasons
---

Receiving "To approve this request, go to Amazon Certificate Approvals"? You are doing it wrong!

# AVOID URGENT Action Required - Your certificate renewal

I have a script like so:

	#!/bin/bash
	awsargs="--region us-east-1"
	certs=$(mktemp)
	trap "{ rm -f $certs; }" EXIT

	if test -z "$1"
	then
	aws $awsargs acm list-certificates \
	| jq '.CertificateSummaryList|sort_by(.DomainName)' > "$certs"
	else
	aws $awsargs acm list-certificates \
	| jq --arg search_string "$1" '[.CertificateSummaryList[]|select(.DomainName | contains($search_string))]' > "$certs"
	fi

	while read -r arn
	do
		aws $awsargs acm describe-certificate --certificate-arn "$arn" | \
		jq '"\(.Certificate.DomainName),\(.Certificate.DomainValidationOptions[1].ValidationMethod),\(.Certificate.CertificateArn)"'
	done <<< $(jq -r .[].CertificateArn "$certs")

From here you want to try get rid of email validation style certificate requests!
