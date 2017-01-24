#!/bin/bash

AS_SEED_NODE=0
CLUSTER_NAME=
INITIAL_HOST=
MAX_HEAP_SIZE=
MIN_HEAP_SIZE=

CASSANDRA_YAML=/etc/cassandra/cassandra.yaml
CASSANDRA_JVM_OPTIONS=/etc/cassandra/jvm.options

while getopts c:i:M:S:s OPTION
do
    case $OPTION in
        c)
            CLUSTER_NAME=${OPTARG};;
        i)
            INITIAL_HOST=${OPTARG};;
        s)
            AS_SEED_NODE=1;;
        M)
            MAX_HEAP_SIZE=${OPTARG};;
        S)
            MIN_HEAP_SIZE=${OPTARG};;
        ?)
            echo 'unknown option'
            exit 1;;
    esac
done

IP_ADDRESS=`hostname --ip-address`

sudo perl -wpi -e 's!^rpc_address:.+!rpc_address: '${IP_ADDRESS}'!' ${CASSANDRA_YAML}
sudo perl -wpi -e 's!^listen_address:.+!listen_address: '${IP_ADDRESS}'!' ${CASSANDRA_YAML}

if [ ${AS_SEED_NODE} -eq 1 ]; then
    sudo sh -c "echo 'auto_bootstrap: false' >> ${CASSANDRA_YAML}"
fi

if [ "${INITIAL_HOST}" != "" ]; then
    sudo perl -wpi -e 's!(.+- seeds:).+!$1 "'${INITIAL_HOST}'"!' ${CASSANDRA_YAML}
else
    sudo perl -wpi -e 's!(.+- seeds:).+!$1 "'${IP_ADDRESS}'"!' ${CASSANDRA_YAML}
fi

if [ "${CLUSTER_NAME}" != "" ]; then
    sudo perl -wpi -e "s!^cluster_name:.+!cluster_name: '""${CLUSTER_NAME}""'!" ${CASSANDRA_YAML}
fi

if [ "${MAX_HEAP_SIZE}" != "" ]; then
    sudo perl -wpi -e 's!^#?-Xmx.+!-Xmx'${MAX_HEAP_SIZE}'!' ${CASSANDRA_JVM_OPTIONS}
fi

if [ "${MIN_HEAP_SIZE}" != "" ]; then
    sudo perl -wpi -e 's!^#?-Xms.+!-Xms'${MIN_HEAP_SIZE}'!' ${CASSANDRA_JVM_OPTIONS}
elif [ "${MAX_HEAP_SIZE}" != "" ]; then
    sudo perl -wpi -e 's!^#?-Xms.+!-Xms'${MAX_HEAP_SIZE}'!' ${CASSANDRA_JVM_OPTIONS}
fi

sudo service cassandra start && tail -f /var/log/cassandra/system.log
