#!/bin/bash

LAUNCH_JBOSS_IN_BACKGROUND=1 \
    bin/standalone.sh -c clustered.xml \
    -Djboss.bind.address=`hostname -I` \
    -Djboss.bind.address.management=`hostname -I` \
    "$@" >/dev/null
