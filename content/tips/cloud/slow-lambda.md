---
title: Slow lambda
date: 2021-04-20T16:23:26+08:00
description: How do you find poor performing lambda functions?
---

# Via an AWS Cloudwatch Insight query

    fields @timestamp, @message, @duration, @requestId
    | filter @duration > 100
