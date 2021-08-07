#!/bin/bash

COCKROACH=/opt/cockroach/cockroach
ADVERTISE_ADDR="`hostname -i`:26257"
STORE_DIR=/var/lib/cockroach/data

if [ $# -eq 0 ]; then
    PRINTABLE_COMMAND="
=======================================================
Startup CockroachDB Command.

-----

${COCKROACH} start-single-node \\
             --insecure \\
             --store=${STORE_DIR} \\
             --advertise-addr=${ADVERTISE_ADDR} \\
             --background

=======================================================

"

    echo "${PRINTABLE_COMMAND}"
    echo "echo '${PRINTABLE_COMMAND}'"  >> ${HOME}/.bashrc

    ${COCKROACH} start-single-node \
                 --insecure \
                 --store=${STORE_DIR} \
                 --advertise-addr=${ADVERTISE_ADDR} \
                 --background

else
    PRINTABLE_COMMAND="
=======================================================
Startup CockroachDB Command.

-----

${COCKROACH} start \\
             --insecure \\
             --store=${STORE_DIR} \\
             --advertise-addr=${ADVERTISE_ADDR} \\
             --background \\
             "$@"

===============

Initialize CockroachDB Cluster Command.

-----

${COCKROACH} init --insecure --host=`hostname -i`:26257

=======================================================

"
    echo "${PRINTABLE_COMMAND}"
    echo "echo '${PRINTABLE_COMMAND}'"  >> ${HOME}/.bashrc
    
    ${COCKROACH} start \
                 --insecure \
                 --store=${STORE_DIR} \
                 --advertise-addr=${ADVERTISE_ADDR} \
                 --background \
                 "$@"
fi

tail -F ${STORE_DIR}/logs/cockroach{,-pebble,-stderr}.log
