#!/bin/bash

MODE=$1

shift

if [ "${MODE}" == 'master' ]; then

    /opt/spark/sbin/start-master.sh "$@"
    tail -f /opt/spark/logs/spark-*.out

elif [ "${MODE}" == "worker" ]; then

    /opt/spark/sbin/start-worker.sh "$@"
    tail -f /opt/spark/logs/spark--org.apache.spark.deploy.worker.Worker-*.out

fi
