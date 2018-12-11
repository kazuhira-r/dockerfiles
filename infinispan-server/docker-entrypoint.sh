#!/bin/bash

LAUNCH_JBOSS_IN_BACKGROUND=1 \
    bin/standalone.sh \
    -Djboss.bind.address=`hostname -i` \
    -Djboss.bind.address.management=0.0.0.0 \
    "$@" >/dev/null 2>&1 &

test -d standalone/log || mkdir standalone/log && \
touch standalone/log/server.log && \
tail -f standalone/log/server.log
