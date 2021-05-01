#!/bin/bash

PID=0

trap "kill $PID" INT

rm -f /var/lib/mysql/auto.cnf

SERVER_ID=`hostname --ip-address | perl -wp -e 's!.+\.(\d+)!$1!'`
perl -wpi -e 's!server_id = .+!server_id = '${SERVER_ID}'!' /etc/mysql/mysql.conf.d/mysqld.cnf

SERVER_ADDRESS=`hostname -i`
perl -wpi -e 's!report-host = ".+"!report-host = "'${SERVER_ADDRESS}'"!' /etc/mysql/mysql.conf.d/mysqld.cnf

/usr/sbin/mysqld --daemonize
PID=$!

echo "'`mysql --version`' started."

PASSWORD=password

SQL_INSECURE_ROOT=$(cat <<EOS
create user root@'%' identified by '${PASSWORD}';
grant all privileges on *.* to root@'%' with grant option;
flush privileges;
reset master;
EOS
)

while true
do
    mysql -uroot -e "${SQL_INSECURE_ROOT}"

    RET=$?

    if [ $RET -eq 0 ]; then
        echo 'registered, root user.'
        break
    fi

    echo 'wait, wakeup MySQL Server...'
    sleep 3
done

tail -f /var/log/mysql/error.log
