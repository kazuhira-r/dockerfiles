#!/bin/bash

PID=0

trap "kill $PID" INT

/usr/sbin/mysqld &
PID=$!

sleep 5

echo "'`mysql --version`' started."

PASSWORD=password

SQL_INSECURE_ROOT=$(cat <<EOS
CREATE USER root@'%' IDENTIFIED BY '${PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO root@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOS
)

mysql -uroot -e "${SQL_INSECURE_ROOT}"

tail -f /var/log/mysql/error.log
