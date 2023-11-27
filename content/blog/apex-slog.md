---
title: Apex log to Structured log
date: 2023-08-09T19:06:41+01:00
description: github.com/apex/log versus log/slog
---
https://github.com/apex/log versus [go1.21's log/slog](https://tip.golang.org/doc/go1.21#slog)

    log.WithField("record", rec).Info("adding")
    slog.Info("test", "record", rec)


https://go.dev/play/p/mVJyQmYTZVe

	log.WithError(errors.New("unauthorized")).Error("upload failed")
    slog.Error("upload failed", "err", errors.New("unauthorized"))

Not sure how to do a Fatal

	log.WithError(err).Fatal("error listening")

Setting the default handler to JSON output:

	log.SetHandler(jsonhandler.Default)
    slog.SetDefault(slog.New(slog.NewJSONHandler(os.Stderr, nil)))

[Default handler outputting to stderr.](https://github.com/apex/log/blob/master/handlers/json/json.go#L14)

    log.WithFields(log.Fields{
            "url":     logoutUrl,
            "profile": profile,
            }).Info("logouting user out")

