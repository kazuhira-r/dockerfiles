#!/bin/bash

SERVER_ID=`hostname -i | perl -wp -e 's!.+\.(\d+)!$1!'`
USER_NAME=repl
PASSWORD=password
SOURCE_HOST=mysqlsource
SOURCE_PORT=3306
SOURCE_AUTO_POSITION=1
SOURCE_HEARTBEAT_PERIOD=60

if [ "$1" != "" ]; then
    SOURCE_HOST=$1
fi

if [ "$2" != "" ]; then
    SERVER_ID=$2
fi

sudo perl -wpi -e 's!server_id = .+!server_id = '${SERVER_ID}'!' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo perl -wpi -e 's!^#read_only!read_only!' /etc/mysql/mysql.conf.d/mysqld.cnf

sudo rm -f /var/lib/mysql/auto.cnf

./restart-mysqld.sh

# mysql --ssl-mode=DISABLED -u${USER_NAME} -p${PASSWORD} -h${SOURCE_HOST} --get-server-public-key -e 'exit'

SQL=$(cat <<EOF
change replication source to source_host = '${SOURCE_HOST}', source_port = ${SOURCE_PORT}, source_ssl = 1, source_auto_position = ${SOURCE_AUTO_POSITION}, source_heartbeat_period = ${SOURCE_HEARTBEAT_PERIOD};
start replica user = '${USER_NAME}' password = '${PASSWORD}';
EOF
)

mysqlsh root:${ROOT_PASSWORD}@localhost:3306 --sql -e "${SQL}"
