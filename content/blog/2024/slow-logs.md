---
title: How to fix the most impactful AWS RDS Slow queries 🐢
date: 2024-10-17T17:26:20+01:00
description: Speeding up slow queries in AWS MySQL instances
---

Assuming the [slow_query_log parameter](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.MySQL.LogFileSize.html) is enabled, ensure you [publish those logs to CloudWatch](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.MySQLDB.PublishtoCloudWatchLogs.html) for analysis. Bonus: Enable [RDS Performance insights](https://aws.amazon.com/rds/performance-insights/) and ensure retention is set to something sensible like a month, which does come at a [additional cost](https://aws.amazon.com/rds/performance-insights/pricing/).

<img src="https://s.natalian.org/2024-10-17/log-filter.png" alt="Log insights search">

Using Logs Insights, you can retrieve slow logs across multiple RDS instances. With the default retention (none), you can go far back in time to pull all the slow logs.

<img src="https://s.natalian.org/2024-10-17/log-insights.png" alt="Log insights date picker">

You can download the individual slow logs with a tool like `aws rds download-db-log-file-portion`, but that typically only a day's worth, hence using log insights is more practical.

You might want look at indexes, but that's usually a red herring. There is a handy option called [log_queries_not_using_indexes](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.MySQL.LogFileSize.html) you might want to enable, nonetheless.

You may want to further filter for specific databases of interest. For example, focusing on SQL Data Manipulation Language (DML) can be most impactful if you have a write heavy workload. Vertically scaling writers remains challenging in 2024 with AWS Aurora for MySQL. Outages caused by vertically scaling are often unavoidable, so it makes sense to ensure that writes are efficient.

To analyse them Export results, click "Download table (JSON)" and convert the JSON back to a flat file:

    jq -r '.[] | "\(.["@message"])"' logs-insights-results.json > slow.logs

Not for the analysis with `brew install percona-toolkit`:

    pt-query-digest slow.logs

<img src="https://s.natalian.org/2024-10-18/pt-query-digest.png" alt="pt-query-digest output">

This will show you the top poorly performing and most impactful queries. Each query will be normalized and assigned an ID like 0x51C9D7BEAD71E9F03961FF1C7528883D, allowing you to identify and address it.

If the query affects many tenants or databases, you can see that in the details of the query, [for example](https://forums.percona.com/t/pt-query-digest-databases-tenants/34369):

    # Databases    foo_d... (42/44%), bar_doc... (26/27%)... 8 more

Now it's time to optimize the prioritised slow query. Ideally, you should recreate the database with anonymized data to try practical refactors, which often involves trial and error to determine where time is being spent. `pt-query-digest`, as you may have noticed, offers commands to recreate the environment and use `EXPLAIN` on the query. 

Remember, [query time is the north star metric](/blog/2024/database-performance/).

Once you have effective query refactors that improve performance, the next step is to update the code that executes the query — a challenging task.

One of the most frustrating problems on a large estate is not knowing where the backend code constructs the poorly performing SQL query.

There could be pseudo-attributes embedded in queries, such as comments like `-- file: /login.php, line: 493;`, as documented in [pt-query-digest's man page](https://docs.percona.com/percona-toolkit/pt-query-digest.html).

However, it's unlikely that such "source mapping" embedded attributes exist, though it would be helpful if they did! You more than likely will spend some time grepping around the code base, trying to work out where the SQL query is constructed.

SQL queries are often constructed by an Object–Relational Mapping (ORM) tool, which can result in poorly performing queries. Every ORM framework offers an "escape hatch" to run a SQL query directly; this is what you might leverage to bypass the ORM and deliver your optimized performant SQL query.

Though more often that not, the design of the UI or API is at fault, depending on their usage. Inadvertedly asking for too much data, passing too many arguments or [not paginating results correctly](https://planetscale.com/blog/mysql-pagination), can result in slow queries that destabilise your platform. APIs are hard to fix, as they are often consumed by existing clients & integrations, and changing the API could well be a breaking change.

What do we have left if you can't index, scale or even fix the code? You need to look at something before the request hits the database:

* AWS Cloudfront
* AWS Web Application Firewall (WAF)
* RDS Proxy - provides connection multi-plexing (making sure it hits a "warm" instance)
* [ProxySQL - non-RDS proxy](https://proxysql.com/documentation/query-rewrite/), but has features that allow query firewalling/re-writing.
* A Circuit breaker or a Rate limiter

I'll cover Circuit breakers & Rate limiters in a later blog post. 
