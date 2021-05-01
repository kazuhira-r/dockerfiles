#!/bin/bash
sudo killall mysqld

sleep 3

while true
do
    sudo /usr/sbin/mysqld --daemonize

    RET=$?

    if [ $RET -eq 0 ]; then
        break
    fi

    echo 'wait, shutdown MySQL Server...'
    sleep 3
done
