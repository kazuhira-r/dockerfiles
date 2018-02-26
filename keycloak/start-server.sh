#!/bin/bash

LAUNCH_JBOSS_IN_BACKGROUND=1 \
    bin/standalone.sh \
    -Djboss.bind.address=0.0.0.0 \
    -Djboss.bind.address.management=0.0.0.0 \
    "$@" >/dev/null
