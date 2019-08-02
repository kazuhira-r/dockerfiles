#!/bin/bash

PID=0

trap "kill $PID" INT

/usr/sbin/mysqld &
PID=$!

echo "'`mysql --version`' started."

tail -f /var/log/mysql/error.log
