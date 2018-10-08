#!/bin/bash

# SERVER_ID=$1
USER_NAME=rpl_user
PASSWORD=password
CONNECT_FROM=%
#CONNECT_FROM=172.17.0.0/255.255.255.0
SERVER_ADDRESS=`hostname -i`

SINGLE_PRIMARY_MODE=$1

if [ "${SINGLE_PRIMARY_MODE}" = "" ]; then
    SINGLE_PRIMARY_MODE=on
fi

# perl -wpi -e 's!server_id = .+!server_id = '${SERVER_ID}'!' /etc/mysql/mysql.conf.d/mysqld.cnf
perl -wpi -e 's!loose-group_replication_local_address = ".+"!loose-group_replication_local_address = "'${SERVER_ADDRESS}':24901"!' /etc/mysql/mysql.conf.d/mysqld.cnf
perl -wpi -e 's!loose-group_replication_group_seeds = ".+"!loose-group_replication_group_seeds = "'${SERVER_ADDRESS}':24901"!' /etc/mysql/mysql.conf.d/mysqld.cnf
perl -wpi -e 's!loose-group_replication_single_primary_mode = .+!loose-group_replication_single_primary_mode = '${SINGLE_PRIMARY_MODE}'!' /etc/mysql/mysql.conf.d/mysqld.cnf
perl -wpi -e 's!report-host = ".+"!report-host = "'${SERVER_ADDRESS}'"!' /etc/mysql/mysql.conf.d/mysqld.cnf

pgrep mysqld | xargs kill

sleep 10

service mysql restart

SQL=$(cat <<EOF
SET SQL_LOG_BIN=0;
CREATE USER ${USER_NAME}@'${CONNECT_FROM}' IDENTIFIED BY '${PASSWORD}';
GRANT REPLICATION SLAVE ON *.* TO ${USER_NAME}@'${CONNECT_FROM}';
FLUSH PRIVILEGES;
SET SQL_LOG_BIN=1;
CHANGE MASTER TO MASTER_USER='${USER_NAME}', MASTER_PASSWORD='${PASSWORD}' FOR CHANNEL 'group_replication_recovery';
INSTALL PLUGIN group_replication SONAME 'group_replication.so';
SHOW PLUGINS;
SET GLOBAL group_replication_bootstrap_group=ON;
START GROUP_REPLICATION;
SET GLOBAL group_replication_bootstrap_group=OFF;
SELECT * FROM performance_schema.replication_group_members;
EOF
)

mysql -uroot -e "${SQL}"