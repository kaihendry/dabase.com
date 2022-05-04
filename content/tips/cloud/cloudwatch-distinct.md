---
title: Unique users via logs
date: 2022-05-04
description: Count how many users you have in your structured logs
---

First you need to finger print your user, e.g. by [setting a
cookie](https://youtu.be/YlrwDN7_vHw?t=226) or hashing the UA string.

    func addContextMiddleware(next http.Handler) http.Handler {
    	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
    		cookie, _ := r.Cookie("visitor")
    		logging := log.WithFields(
    			log.Fields{
    				"id":      r.Header.Get("X-Request-Id"),
    				"country": r.Header.Get("Cloudfront-Viewer-Country"),
    				"ua":      r.UserAgent(),
    			})
    		if cookie != nil {
    			cvisitor := context.WithValue(r.Context(), visitor, cookie.Value)
    			logging = logging.WithField("visitor", cookie.Value)
    			clog := context.WithValue(cvisitor, logger, logging)
    			next.ServeHTTP(w, r.WithContext(clog))
    		} else {
    			visitorID, _ := generateRandomString(24)
    			// log.Infof("Generating vistor id: %s", visitorID)
    			expiration := time.Now().Add(365 * 24 * time.Hour)
    			setCookie := http.Cookie{Name: "visitor", Value: visitorID, Expires: expiration}
    			http.SetCookie(w, &setCookie)
    			cvisitor := context.WithValue(r.Context(), visitor, visitorID)
    			logging = logging.WithField("visitor", visitorID)
    			clog := context.WithValue(cvisitor, logger, logging)
    			next.ServeHTTP(w, r.WithContext(clog))
    		}
    	})
    }

Once you are logging a unique **visitor** attribute in your logs, you can count your users!

<img src="https://s.natalian.org/2022-05-04/distinct-users.png" alt="Count distinct users">

A **Log insights** query like:

    fields @timestamp, fields.visitor
    | sort @timestamp desc
    | filter ispresent(fields.visitor)
    | stats count_distinct(fields.visitor) by bin(1h)
