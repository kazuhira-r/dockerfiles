#!/bin/bash

LAUNCH_ISPN_IN_BACKGROUND=1 \
    bin/server.sh \
    -b 0.0.0.0 \
    -Djgroups.tcp.address=`hostname -i` \
    "$@" &

tail -f /dev/null
