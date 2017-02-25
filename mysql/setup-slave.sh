#!/bin/bash

SERVER_ID=$1
USER_NAME=repl
PASSWORD=password
MASTER_HOST=mysqlmaster
MASTER_PORT=3306
MASTER_AUTO_POSITION=1
MASTER_HEARTBEAT_PERIOD=60

if [ "$2" != "" ]; then
    MASTER_HOST=$2
fi

perl -wpi -e 's!server_id = .+!server_id = '${SERVER_ID}'!' /etc/mysql/mysql.conf.d/mysqld.cnf
perl -wpi -e 's!^#read_only!read_only!' /etc/mysql/mysql.conf.d/mysqld.cnf

rm -f /var/lib/mysql/auto.cnf

service mysql restart

SQL=$(cat <<EOF
CHANGE MASTER TO MASTER_HOST = '${MASTER_HOST}', MASTER_PORT = ${MASTER_PORT}, MASTER_AUTO_POSITION = ${MASTER_AUTO_POSITION}, MASTER_HEARTBEAT_PERIOD = ${MASTER_HEARTBEAT_PERIOD};
START SLAVE USER = '${USER_NAME}' PASSWORD = '${PASSWORD}';
EOF
)

mysql -uroot -e "${SQL}"
