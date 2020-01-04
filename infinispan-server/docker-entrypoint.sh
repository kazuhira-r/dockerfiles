#!/bin/bash

LAUNCH_ISPN_IN_BACKGROUND=1 \
    bin/server.sh \
    -Dinfinispan.bind.address=0.0.0.0 \
    "$@" &

tail -f /dev/null
