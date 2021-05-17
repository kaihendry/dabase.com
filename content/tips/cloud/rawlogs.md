---
title: RAW AWS Logs
date: 2021-05-17
description: How does AWS store your logs?
---

This is how [AWS CloudWatch stores your logs](https://s.natalian.org/2021-05-17/events.json):

<img src="https://s.natalian.org/2021-05-17/1621259231_1918x1047.png" alt="get-log-events">

# How to fetch the last log given a log group name

	aws logs describe-log-streams --log-group-name "/aws/lambda/bus" --max-items 1 --order-by LastEventTime --descending
	{
		"logStreams": [
			{
				"logStreamName": "2021/05/17/[144]8f55c06a90df4c84a84c19f25d3df6ff",
				"creationTime": 1621261088376,
				"firstEventTimestamp": 1621261080544,
				"lastEventTimestamp": 1621261081829,
				"lastIngestionTime": 1621261164779,
				"uploadSequenceToken": "49616633598735372912937322305425484023201980440079640002",
				"arn": "arn:aws:logs:ap-southeast-1:407461997746:log-group:/aws/lambda/bus:log-stream:2021/05/17/[144]8f55c06a90df4c84a84c19f25d3df6ff",
				"storedBytes": 0
			}
		],
		"NextToken": "eyJuZXh0VG9rZW4iOiBudWxsLCAiYm90b190cnVuY2F0ZV9hbW91bnQiOiAxfQ=="
	}

And now to fetch the **raw logs**:

	aws logs get-log-events --log-group-name "/aws/lambda/bus" --log-stream-name "2021/05/17/[144]8f55c06a90df4c84a84c19f25d3df6ff"

When logs are sent to [AWS CloudWatch the timestamp is extracted from the message and an **ingestionTime** is added](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_AnalyzeLogData-discoverable-fields.html).
