#!/bin/bash

LAUNCH_ISPN_IN_BACKGROUND=1 \
    bin/server.sh \
    -Dinfinispan.bind.address=0.0.0.0 \
    -Djgroups.tcp.address=`hostname -i` \
    "$@" &

tail -f /dev/null
