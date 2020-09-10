#!/bin/bash

perl -wpi -e 's!bindIp: 127.0.0.1!bindIp: 0.0.0.0!g' /opt/mongodb/conf/mongod.conf
perl -wpi -e 's!/var/lib/mongodb!/opt/mongodb/data!g' /opt/mongodb/conf/mongod.conf
perl -wpi -e 's!/var/log/mongodb!/opt/mongodb/log!g' /opt/mongodb/conf/mongod.conf

/opt/mongodb/bin/mongod --config /opt/mongodb/conf/mongod.conf &

sleep 3

tail -f /opt/mongodb/log/mongod.log
