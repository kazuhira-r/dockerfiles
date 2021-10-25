#!/bin/bash

DATABASE_NAME=$1
USER_NAME=$2
PASSWORD=$3
OPTION=$4

WITH_OPTION=

# example: WITH mysql_native_password
if [ "${OPTION}" != "" ]; then
    WITH_OPTION="with ${OPTION}"
fi

SQL=$(cat <<EOF
create database if not exists ${DATABASE_NAME};

create user ${USER_NAME}@localhost identified ${WITH_OPTION} by '${PASSWORD}';
create user ${USER_NAME}@'%' identified ${WITH_OPTION} by '${PASSWORD}';

grant all privileges on ${DATABASE_NAME}.* to ${USER_NAME}@localhost;
grant all privileges on ${DATABASE_NAME}.* to ${USER_NAME}@'%';

flush privileges;
EOF
)

mysql -uroot -ppassword -h`hostname -i` -e "${SQL}"
