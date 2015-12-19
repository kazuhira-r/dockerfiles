#!/bin/bash

infinispan-server/bin/standalone.sh -c clustered.xml -Djboss.bind.address=`hostname -I` "$@"
