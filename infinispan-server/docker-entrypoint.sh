#!/bin/bash

LAUNCH_ISPN_IN_BACKGROUND=1 \
    bin/server.sh \
    -Dinfinispan.bind.address=`hostname -i` \
    "$@" >/dev/null 2>&1 &

test -d server/log || mkdir server/log && \
touch server/log/server.log && \
tail -f server/log/server.log
