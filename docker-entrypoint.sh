#!/bin/sh

mysqld --daemonize

for SQL_FILE in $(ls /init.db | grep -E '.sql')
do
  mysql < ${SQL_FILE}
done

apache2ctl -D FOREGROUND
