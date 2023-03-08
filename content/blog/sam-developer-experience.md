---
title: AWS SAM Developer Experience
date: 2023-02-28T19:55:42+08:00
description: AWS SAM DX failures
toc: true
---

{{< tweet user="ibuildthecloud" id="1630324949452996608" >}}

## Unexpected error 🤮

    Error: Unable to locate credentials
    Traceback:
      File "click/core.py", line 1055, in main
      File "click/core.py", line 1657, in invoke
      File "click/core.py", line 1404, in invoke
      File "click/core.py", line 760, in invoke
      File "samcli/lib/cli_validation/image_repository_validation.py", line 92, in wrapped
      File "click/decorators.py", line 84, in new_func
      File "click/core.py", line 760, in invoke
      File "samcli/lib/telemetry/metric.py", line 183, in wrapped
      File "samcli/lib/telemetry/metric.py", line 150, in wrapped
      File "samcli/lib/utils/version_checker.py", line 41, in wrapped
      File "samcli/cli/main.py", line 92, in wrapper
      File "samcli/commands/_utils/cdk_support_decorators.py", line 38, in wrapped
      File "samcli/commands/deploy/command.py", line 221, in cli
      File "samcli/commands/deploy/command.py", line 289, in do_cli
      File "samcli/lib/bootstrap/bootstrap.py", line 23, in manage_stack
      File "samcli/lib/utils/managed_cloudformation_stack.py", line 145, in manage_stack
      File "samcli/lib/utils/managed_cloudformation_stack.py", line 156, in _create_or_get_stack
      File "botocore/client.py", line 401, in _api_call
      File "botocore/client.py", line 718, in _make_api_call
      File "botocore/client.py", line 737, in _make_request
      File "botocore/endpoint.py", line 107, in make_request
      File "botocore/endpoint.py", line 180, in _send_request
      File "botocore/endpoint.py", line 121, in create_request
      File "botocore/hooks.py", line 358, in emit
      File "botocore/hooks.py", line 229, in emit
      File "botocore/hooks.py", line 212, in _emit
      File "botocore/signers.py", line 95, in handler
      File "botocore/signers.py", line 167, in sign
      File "botocore/auth.py", line 401, in add_auth

    An unexpected error was encountered while executing "sam deploy".
    Search for an existing issue:
    https://github.com/aws/aws-sam-cli/issues?q=is%3Aissue+is%3Aopen+Bug%3A%20sam%20deploy%20-%20NoCredentialsError
    Or create a bug report:
    https://github.com/aws/aws-sam-cli/issues/new?template=Bug_report.md&title=Bug%3A%20sam%20deploy%20-%20NoCredentialsError

## No way to add retention to default log

https://github.com/aws/serverless-application-model/issues/972

## No way to deploy without creating a Cloudformation change

https://github.com/aws/aws-sam-cli/issues/4287

## No way to see the CNAME API once deploying

https://github.com/aws/aws-sam-cli/issues/4670

## Runtime: provided.al2

The developer experience one has to jump to deploy to **arm64** is painful. For
example you [must name your executable **bootstrap**](https://twitter.com/wolfeidau/status/1633292328285933568).

## No static binary

sam cli is non-trivial to install with its Python dependencies. I am not sure how this can be considered a [one click install](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/install-sam-cli.html#install-sam-cli-instructions). A static binary would be so much better.

## Refactoring the template.yml can cause a UPDATE_FAILED

https://github.com/aws/aws-sam-cli/issues/4670#issuecomment-1437823765

## Logging experience is awful

Compare [sam logs](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/sam-cli-command-reference-sam-logs.html) to [up logs](/blog/2023/apex-up-logs/). Also the formatting is terrible:

<img src="https://s.natalian.org/2023-03-01/samlogs.png" alt="sam logs --stack-name helloworld-sam --tail">

# Public roadmap

- https://github.com/aws/aws-sam-cli/discussions/4689
- https://github.com/aws/aws-sam-cli/wiki/AWS-SAM-CLI-Roadmap

My [minimal AWS SAM helloworld](https://github.com/kaihendry/helloworld)
