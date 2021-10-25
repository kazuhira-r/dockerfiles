#!/bin/bash

SERVER_ID=1
USER_NAME=repl
PASSWORD=password
CONNECT_FROM=%
#CONNECT_FROM=172.17.0.0/255.255.255.0

# perl -wpi -e 's!#server_id = %id%!server_id = '${SERVER_ID}'!' /etc/mysql/mysql.conf.d/mysqld.cnf

SQL=$(cat <<EOF
create user '${USER_NAME}'@'${CONNECT_FROM}' identified by '${PASSWORD}';
grant replication slave on *.* to '${USER_NAME}'@'${CONNECT_FROM}';
EOF
)

mysql -uroot -p${ROOT_PASSWORD} -h`hostname -i` -e "${SQL}"

./restart-mysqld.sh
