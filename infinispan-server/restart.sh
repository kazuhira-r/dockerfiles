#!/bin/bash

SCRIPT_DIR=$(cd `dirname $0` && pwd)

kill `pgrep server.sh`

sleep 3

LAUNCH_ISPN_IN_BACKGROUND=1 \
    bin/server.sh \
    -b 0.0.0.0 \
    -Djgroups.tcp.address=`hostname -i` \
    "$@" >> /tmp/stdout.log &
