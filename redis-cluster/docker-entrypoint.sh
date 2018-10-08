#!/bin/bash

if [ "$1" != "" ]; then
    PORT=$1
else
    PORT=6379
fi

perl -wp -e "s!%PORT%!${PORT}!" conf/redis.conf.template > conf/redis.conf

bin/redis-server conf/redis.conf
