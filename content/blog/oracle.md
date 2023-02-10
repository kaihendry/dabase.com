---
title: oracledump
date: 2023-02-10T16:41:29+08:00
description: Oracle dump to SQL from an oradata folder for a CI/CD pipeline
---

As a devops engineer, I work with CI/CD pipelines. Creating, maintaining, fixing
and speeding them up.

When I heard of a job that takes 30 minutes, I had to investigate and I found:

1. oradata.tar.gz ~ 1.2GB, extracted to 8GB
2. an old oracle version (no other would work with this), was used to bootstrap with it to run tests

Can it bootstrap faster and save developers a chunk of time?

# Oracle containers

A quick google reveals https://github.com/gvenzl/oci-oracle-xe#image-flavors with **faststart** for faster database startup times.

Great, but now I need to convert **oradata to SQL** for **/container-entrypoint-initdb.d**.

# There is no Oracle dump

A rediculous amount of time was lost with trial and error on Oracle's frankly
broken CLI tools upon
https://github.com/kaihendry/oracle-sql/blob/main/Makefile

* sqlplus - can't export to sqlfile
* impdp - can't export data to sqlfile
* sqlcl - can only go table by table

[Unloading a table to Insert
statements](https://github.com/kaihendry/oracle-sql/blob/main/unload.sh) is
hugely problematic because of foreign key constraints. There is a work around
to disable the constraints table by table and then put them back once all the
data is imported. For example:

	ALTER TABLE sales MODIFY CONSTRAINT sales_promo_fk  DISABLE;
	ALTER TABLE sales MODIFY CONSTRAINT sales_promo_fk  ENABLE;

# Non-CLI GUI options

I found [dbeaver](https://dbeaver.io) and [datagrip both broken with Oracle](https://intellij-support.jetbrains.com/hc/en-us/community/posts/9878603783826-Oracle-is-not-supported-very-well).

Your best bet is [Oracle SQL Developer](https://www.oracle.com/database/sqldeveloper/).

Despite Oracle's SQL developer being slow, unstable and limited wrt how many
rows it can export; it was the best export to SQL tool. To make it workable I
had to ensure no table had more than a 1000 rows of test data.

The next issue is service name which is omitted in the export. Prepend:

	ALTER SESSION SET CONTAINER=XEPDB1

Next issue; my users were not setup. Usually there is admin/user paradigm, so mine look something like:

	CREATE USER eg_development_owner IDENTIFIED BY eg_development_owner QUOTA UNLIMITED ON USERS;
	GRANT CONNECT, CREATE SYNONYM, RESOURCE TO eg_development_owner;
	CREATE USER eg_development IDENTIFIED BY eg_development QUOTA UNLIMITED ON USERS;
	GRANT CONNECT, RESOURCE TO eg_development;
	GRANT CREATE SYNONYM to eg_development;

My biggest stumbling block was not being able to login with the
ORACLE_PASSWORD.  You need to set the role as SYSDBA on their client!

# prime.sql

Now I have a ~1M bootstrap `/container-entrypoint-initdb.d/prime.sql` down from
a ~8GB oradata folder. It takes about **four minutes** to bootstrap currently to a
**DATABASE IS READY TO USE!** state.

Do have a look at my [Oracle CLI
experiments](https://github.com/kaihendry/oracle-sql) and do please offer any
suggestions.
