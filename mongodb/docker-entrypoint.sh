#!/bin/bash

sudo perl -wpi -e 's!bindIp: 127.0.0.1!bindIp: 0.0.0.0!g' /etc/mongod.conf

sudo /usr/bin/mongod --config /etc/mongod.conf &

sleep 3

sudo tail -f /var/log/mongodb/mongod.log
