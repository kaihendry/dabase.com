---
date: 2014-05-16 19:18:36 +0800
---

I do like [AWS S3](https://console.aws.amazon.com/s3), but on the topic of
policy/security languages, IIUC Amazon have fecked up by having THREE of them.

<img src=http://s.natalian.org/2014-05-16/s3-permissions-policy.png />

1. permissions Web UI
* policy
* CORS configuration

What to add anonymous public listing? You could:

1. Click "Add more permissions"
* On the **Grantee** drop down box, select Everyone (not sure why I'm called hendry60 and "me")
* Ensure listing is selected and Save

Or using the [AWS cli](https://aws.amazon.com/cli/):

	aws s3api put-bucket-acl --bucket BUCKET_NAME --acl public-read
