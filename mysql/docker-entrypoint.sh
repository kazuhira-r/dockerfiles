#!/bin/bash

PID=0

trap "kill $PID" INT

rm -f /var/lib/mysql/auto.cnf

SERVER_ID=`hostname --ip-address | perl -wp -e 's!.+\.(\d+)!$1!'`
perl -wpi -e 's!server_id = .+!server_id = '${SERVER_ID}'!' /etc/mysql/mysql.conf.d/mysqld.cnf

SERVER_ADDRESS=`hostname -i`
perl -wpi -e 's!report-host = ".+"!report-host = "'${SERVER_ADDRESS}'"!' /etc/mysql/mysql.conf.d/mysqld.cnf

/usr/sbin/mysqld &
PID=$!

sleep 10

echo "'`mysql --version`' started."

PASSWORD=password

SQL_INSECURE_ROOT=$(cat <<EOS
CREATE USER root@'%' IDENTIFIED BY '${PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO root@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
RESET MASTER;
EOS
)

mysql -uroot -e "${SQL_INSECURE_ROOT}"

tail -f /var/log/mysql/error.log
