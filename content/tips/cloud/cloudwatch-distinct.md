---
title: Unique users via logs
date: 2022-05-04
description: Count how many users you have in your structured logs
---

{{< youtube 7805qzOmEuk >}}

First you need to finger print your user, e.g. by [setting a
cookie](https://youtu.be/YlrwDN7_vHw?t=226), here I just use milliseconds since epoch:

	func uniqueVisitor(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			cookie, _ := r.Cookie("visitor")
			if cookie != nil {
				slog.Info("returning visitor", "vistor", cookie.Value)
			} else {
				setCookie := http.Cookie{Name: "visitor", Value: fmt.Sprint("visitor-", time.Now().UnixMilli()), Expires: time.Now().Add(365 * 24 * time.Hour)}
				http.SetCookie(w, &setCookie)
			}
			next.ServeHTTP(w, r)
		})
	}

Once you are logging a unique **visitor** attribute in your logs, you can count your users!

<img src="https://s.natalian.org/2022-05-04/distinct-users.png" alt="Count distinct users">

A **Log insights** query like:

    fields @timestamp, fields.visitor
    | sort @timestamp desc
    | filter ispresent(fields.visitor)
    | stats count_distinct(fields.visitor) by bin(1h)

Check the Amazon documentation for more [sample queries](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax-examples.html).

Also do checkout: https://www.rehanvdm.com/blog/aws-serverless-you-might-not-need-third-party-monitoring
