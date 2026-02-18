---
title: "Python uv Upgrade"
date: 2026-01-07T19:52:36Z
description: Upgrading Python dependencies in uv based pyproject.toml
---

> We don't support updating the bounds in the pyproject.toml yet, so if you're not looking for uv lock --upgrade, then https://github.com/astral-sh/uv/issues/6794 is the tracking issue (which includes various workarounds)


    uvx uv-upx upgrade run


https://pypi.org/project/uv-upx/

# Not working?

    dependencies = [
        "aws-cdk-lib==2.000",
        "constructs>=10.4.4,<11.0.0",
    ]

Adjust '==' pin to '>='

Bonus: Use `uvx taplo fmt pyproject.toml` to format the pyproject.toml.
