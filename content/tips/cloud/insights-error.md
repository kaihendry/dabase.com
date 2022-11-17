---
title: Cloudwatch Insights
date: 2022-11-17
description: Surfacing errors
---

Only show the **log** field that matches "ERROR"

    fields @timestamp, @message
    | sort @timestamp desc
    | filter @message like "ERROR"
    | display log

https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax.html#CWL_QuerySyntax-commnds

{{< youtube 7805qzOmEuk >}}
