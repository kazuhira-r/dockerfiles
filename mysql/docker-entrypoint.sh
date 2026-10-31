#!/bin/bash

PID=0

trap "kill $PID" INT

rm -f /var/lib/mysql/auto.cnf

SERVER_ID=$(hostname -i | perl -wp -e 's!.+\.(\d+)!$1!')
perl -wpi -e 's!server_id = .+!server_id = '${SERVER_ID}'!' /etc/mysql/mysql.conf.d/mysqld.cnf

SERVER_ADDRESS=$(hostname -i)
perl -wpi -e 's!report-host = ".+"!report-host = "'${SERVER_ADDRESS}'"!' /etc/mysql/mysql.conf.d/mysqld.cnf

/usr/sbin/mysqld --daemonize
PID=$!

echo "'$(mysql --version)' started."

tail -f /var/log/mysql/error.log
