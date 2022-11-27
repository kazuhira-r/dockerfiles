#!/bin/bash

touch /tmp/stdout.log

LAUNCH_ISPN_IN_BACKGROUND=1 \
    bin/server.sh \
    -b 0.0.0.0 \
    -Djgroups.tcp.address=$(hostname -i) \
    "$@" > /tmp/stdout.log &

tail -f /tmp/stdout.log
