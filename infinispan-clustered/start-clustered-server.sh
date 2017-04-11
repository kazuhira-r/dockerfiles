#!/bin/bash

LAUNCH_JBOSS_IN_BACKGROUND=1 \
    bin/standalone.sh -c clustered.xml \
    -Djboss.bind.address=`hostname -i` \
    -Djboss.bind.address.management=0.0.0.0 \
    "$@" >/dev/null
