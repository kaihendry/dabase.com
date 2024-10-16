---
title: AWS SSO with Google Chrome profiles
date: 2024-10-16T09:56:41+01:00
description: Mapping AWS profiles to Chrome profiles
---

When working on many different AWS accounts with different clients, my strategy is to keep them seperated by Google Chrome profiles.

Unfortunately it's non-trivial to list the actual profile names in the Chrome UI or perhaps I don't know how to do it!

    ❯ cd "$HOME/Library/Application Support/Google/Chrome"
    ❯ ls -d1 Prof*
    'Profile 1'
    'Profile 2'
    'Profile 13'

I test each profile to work out the correct client profile like so:

    open -na "Google Chrome" --args --profile-directory="Profile 13" https://example.com

Furthermore when using [aws configure sso](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html) it appears non-trivial to select say "Profile 13".

# Selecting the browser profile

I've figured out how to do this with https://www.granted.dev/

    brew tap common-fate/granted
    brew install granted

Then you might need to alias `assume`.

The configuration is gnarly but it works:

    ❯ cat .granted/config
    DefaultBrowser = "CHROME"
    CustomBrowserPath = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
    CustomSSOBrowserPath = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
    Ordering = ""
    ExportCredentialSuffix = ""

    [SSOBrowserLaunchTemplate]
    Command = "\"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome\" {{ .URL }} --args \"--profile-directory=Profile 13\" "

    [Keyring]
    Backend = "keychain"

When it's working, you should be able to switch between roles running `assume`, and unlike `aws sso login` it should open the correct browser profile.

> [TODO figure out how to make a map between browser profiles and AWS profiles.](https://github.com/common-fate/granted/issues/782)

# References

* https://www.reddit.com/r/aws/comments/1g4gqsu/aws_configure_sso_or_leapp/