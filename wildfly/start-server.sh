#!/bin/bash

LAUNCH_JBOSS_IN_BACKGROUND=1 \
    bin/standalone.sh \
    -Djboss.bind.address=`hostname -I` \
    -Djboss.bind.address.management=`hostname -I` \
    "$@" >/dev/null
