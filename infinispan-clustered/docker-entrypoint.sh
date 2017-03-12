#!/bin/bash

./start-clustered-server.sh 2>&1 &

test -d standalone/log || mkdir standalone/log && \
touch standalone/log/server.log && \
tail -f standalone/log/server.log
