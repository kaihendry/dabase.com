---
title: Rebuild in Codepipeline
date: 2021-10-22
description: Retrying a build which occurred for a previous commit via Codepipeline
---

I'm afraid it is not possible to run an older source version with CodePipeline without actually reverting your source repository back to that version. Thus, in order to re-build the previous source you will have to manually run the build using "Build Overrides". Please refer [1] for more information on Starting builds with Overrides.

Looking at "3c162bb73076c3466c07f93cd3c360e2086f8df6" it seems to be the CommitId of your source which triggered pipeline execution ID "ca6dbfc5-7c9e-47c4-bd67-f2044ed610d4". The build for this pipeline was started at " 2021-10-08T10:08:09 UTC" which appears to be build with BuildId "dev-spm-backend-codebuild:59734478-07e0-430c-ab29-652b9b8e32d3" for which the source version is "arn:aws:s3:::dev-spm-backend-codepipeline/dev-spm-backend-code/codepipeli/FIA02gi".

You can retry a build with this source version using the below steps:

1. Navigate to the build project.

2. Click on "Start build with overrides" button.

3. For the "Source version" field enter "arn:aws:s3:::dev-spm-backend-codepipeline/dev-spm-backend-code/codepipeli/FIA02gi" and click on "Start build", this will start a build with the required, previous source.
