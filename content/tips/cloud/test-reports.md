---
title: AWS Codebuild Test reports
date: 2022-04-29
description: Instead of a large build log, use a report
---

<img src="https://s.natalian.org/2022-04-29/test-reports.png">

Adding to the AWS `buildspec.yml`:

    reports:
      jest_reports:
    	files:
    	  - junit.xml
    	file-format: JUNITXML
    	base-directory: test-results/

And to your Jest configuration `jest.config.js`:

    reporters: [
        'default',
        [
            'jest-junit',
            {
                outputDirectory: './test-results',
                outputName: 'junit.xml',
            },
        ],
    ],

https://docs.aws.amazon.com/codebuild/latest/userguide/test-report-jest.html
