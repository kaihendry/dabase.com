---
title: Connecting to MySQL
date: 2024-07-26T16:52:17+02:00
description: Can't connect to local MySQL server through socket
---

By default the mysql client tries to make a connection via a Unix pipe which might not exist.

    hendry@manza:~$ mysql --user=root
    ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2)

Solution is to specify the TCP protocol:

    hendry@manza:~$ mysql --protocol=TCP
    Welcome to the MySQL monitor.  Commands end with ; or \g.
    Your MySQL connection id is 82
    Server version: 8.0.33 MySQL Community Server - GPL

    Copyright (c) 2000, 2024, Oracle and/or its affiliates.

    Oracle is a registered trademark of Oracle Corporation and/or its
    affiliates. Other names may be trademarks of their respective
    owners.

    Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

    mysql>


This is what `mysqlworkbench` does by default.