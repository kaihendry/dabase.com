---
title: Automated Gsuite Export
date: 2021-01-22T19:49:52+08:00
description: How to download documents like Google Docs and Sheets programatically
---

Automated authentication in order to use [Google Drive API](https://developers.google.com/drive/api/v3/enable-drive-api) is non-trivial.

* First you need to create a <abbr title="Google Cloud Project">GCP</abbr> project
* Then you need to [enable the API](https://developers.google.com/drive/api/v3/enable-drive-api)

Now there is the types of credentials:

1. Service account aka `credentials.json`
2. Oauth with **ClientID** et al.


## Service account

_Service accounts_ have an issue whereby it needs
   [domain-wide-delegation](https://admin.google.com/ac/owl/domainwidedelegation)
   by your **G Suite Administrators** (no one knows who these people are in large
   companies) to **impersonate yourself** with your own @example.com company email.


> Note: Although you can use service accounts in applications that run from
a G Suite domain, service accounts are not members of your G Suite account
and aren’t subject to domain policies set by G Suite administrators. For
example, a policy set in the G Suite admin console to restrict the ability
of G Suite end users to share documents outside of the domain would not
apply to service accounts.

from <https://developers.google.com/identity/protocols/oauth2#serviceaccount>


The work around is to use your credential's email:

	$ grep email credentials.json
	  "client_email": "$name@$project.iam.gserviceaccount.com",

And explicitly share that email address with documents you want to export with this account.

<img src="https://s.natalian.org/2021-01-22/signup.png">


	from googleapiclient.discovery import build
	from google.oauth2 import service_account
	SCOPES = ['https://www.googleapis.com/auth/drive']
	SERVICE_ACCOUNT_FILE = 'credentials.json'

	# We use the SERVICE_ACCOUNT_FILE we just downloaded and the SCOPES we defined to create a Credentials object.
	credentials = service_account.Credentials.from_service_account_file(SERVICE_ACCOUNT_FILE, scopes=SCOPES)

	# Remember, you must have created credentials.json with domain-wide delegation!
	credentials = credentials.with_subject('gdrive@dlsuite.iam.gserviceaccount.com')

	# We build a drive_v3 service using the credentials we just created
	service = build('drive', 'v3', credentials=credentials)

	files = service.files()
	service.files().get(fileId='141g8UkQfdMQSTfIn475gHj1ezZVV16f5ONDxpWrrvts').execute()
	fconr = files.export(fileId='141g8UkQfdMQSTfIn475gHj1ezZVV16f5ONDxpWrrvts',
						 mimeType='application/vnd.openxmlformats-officedocument.wordprocessingml.document')

	fcont = fconr.execute()

	print('{}...'.format(fcont[:10]))

	file = open("/tmp/sample.doc", "wb")
	file.write(fcont)
	file.close()

Via [this notebook](https://github.com/jdsalaro/snippets/blob/main/google_drive_api/stackoverflow-65820541-how-to-download-g-suite-docs-sheets-to-pdf-xls-programatically.ipynb) and this [answer](https://stackoverflow.com/a/65821840/4534) by [Jayson Salazar](https://jdsalaro.com/)


# Oauth token interchange from ClientID

<img src="https://s.natalian.org/2021-01-22/token.png">

After setting the API `https://www.googleapis.com/auth/drive` scope, generating/maintaining the token from **Authorization code** seems non-trivial to me. The [Oauth Playground](https://developers.google.com/oauthplayground/?scope=https://www.googleapis.com/auth/drive) (with its own ClientID) does this automatically for you. But to do this yourself from Python appears non-trivial to me.

When you use the "Try this API" aka "google-apis-explorer" Google application <https://developers.google.com/drive/api/v3/reference/files/export>, again the Oauth interchange dance is already done for you:

<img src="https://s.natalian.org/2021-01-22/credentials.png">

However if you want your App to do this, it appears non-trivial as it needs
some explicit Oauth consent interchange. However once you do have the token, it's straightforward to work with unlike `credentials.json`:

	mimeType=application/pdf
	curl -H "Authorization: Bearer $token" -o doc.pdf \
	https://www.googleapis.com/drive/v3/files/${id}/export?mimeType=$mimeType

Here I believe you impersonate yourself via the ClientID, without the scary [Share outside of organization](https://s.natalian.org/2021-01-22/org.png) message.
