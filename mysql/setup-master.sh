#!/bin/bash

SERVER_ID=1
USER_NAME=repl
PASSWORD=password
CONNECT_FROM=%
#CONNECT_FROM=172.17.0.0/255.255.255.0

# perl -wpi -e 's!#server_id = %id%!server_id = '${SERVER_ID}'!' /etc/mysql/mysql.conf.d/mysqld.cnf

SQL=$(cat <<EOF
CREATE USER '${USER_NAME}'@'${CONNECT_FROM}' IDENTIFIED BY '${PASSWORD}';
GRANT REPLICATION SLAVE ON *.* TO '${USER_NAME}'@'${CONNECT_FROM}';
EOF
)

mysql -uroot -e "${SQL}"

service mysql restart
