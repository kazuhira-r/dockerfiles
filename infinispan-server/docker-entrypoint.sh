#!/bin/bash

LAUNCH_ISPN_IN_BACKGROUND=1 \
    bin/server.sh \
    -Dinfinispan.bind.address=`hostname -i` \
    "$@" &

tail -f /dev/null
