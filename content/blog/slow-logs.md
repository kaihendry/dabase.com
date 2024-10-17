---
title: How to fix the most impactful AWS RDS Slow queries 🐢
date: 2024-10-17T17:26:20+01:00
description: Speeding up slow queries in AWS MySQL instances
---

Assuming the [slow_query_log parameter](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.MySQL.LogFileSize.html) is enabled, ensure you [publish those logs to CloudWatch](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.MySQLDB.PublishtoCloudWatchLogs.html) for analysis.

<img src="https://s.natalian.org/2024-10-17/log-filter.png" alt="Log insights search">

Using Logs Insights, you can retrieve slow logs across multiple RDS instances. With the default retention (none), you can go far back in time to pull all the slow logs.

<img src="https://s.natalian.org/2024-10-17/log-insights.png" alt="Log insights date picker">

You can download the individual slow logs with a tool like `aws rds download-db-log-file-portion`, but that typically only a day's worth, hence using log insights is more practical.

You may want to further filter for specific databases of interest. For example, focusing on writers is most impactful, since vertically scaling writers remains challenging in 2024 with AWS Aurora for MySQL. Outages are often unavoidable, hence it makes sense to make sure writes are efficient.

To analyse them Export results, click "Download table (JSON)"

    jq -r '.[] | "\(.["@message"])"' logs-insights-results.json > slow.logs

Using `brew install percona-toolkit`:

    pt-query-digest slow.logs

<img src="https://i.imgur.com/jd5cOVH.png" alt="pt-query-digest output">

This will show you the top poorly performing and most impactful queries. Each query will be normalized and assigned an ID like 0x51C9D7BEAD71E9F03961FF1C7528883D, allowing you to identify and address it.

If the query affects many tenants or databases, you can see that in the details of the query, [for example](https://forums.percona.com/t/pt-query-digest-databases-tenants/34369).

    # Databases    foo_d... (42/44%), bar_doc... (26/27%)... 8 more

Now it's time to optimize the prioritised slow query. Ideally, you should recreate the database with anonymized data to try practical refactors, which often involves trial and error to determine where time is being spent. `pt-query-digest`, as you may have noticed, offers commands to recreate the environment and use `EXPLAIN` on the query. 

Remember, [query time is the north star metric](/blog/2024/database-performance/).

Once you have effective query refactors that improve performance, the next step is to update the code that executes the query — a challenging task.

One of the most frustrating problems on a large estate is not knowing where the backend code constructs the poorly performing SQL query.

There could be pseudo-attributes embedded in queries, such as comments like `-- file: /login.php, line: 493;`, as documented in [pt-query-digest's man page](https://docs.percona.com/percona-toolkit/pt-query-digest.html).

However, it's unlikely that such "source mapping" embedded attributes exist, though it would be helpful if they did! You more than likely will spend some time grepping around the code base, trying to work out where the SQL query is constructed.

SQL queries are often constructed by an Object–Relational Mapping (ORM) tool, which can result in poorly performing queries. Every ORM framework offers an "escape hatch" to run a SQL query directly; this is what you may to leverage to bypass the ORM and deploy your optimized performant SQL query.

Though more often that not, the design of the UI or API is at fault. Asking for too much data, allowing for too many arguments or [not paginating results correctly](https://planetscale.com/blog/mysql-pagination), can result in slow queries that destabilise your platform. APIs are hard to fix, as they are often consumed by many clients & integrations, and changing the API is a breaking change.



