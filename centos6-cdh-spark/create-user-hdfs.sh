#!/bin/bash

USER_NAME=$1

if [ `whoami` == 'hdfs' ]; then
    HDFS_COMMAND='hdfs'
else
    HDFS_COMMAND='sudo -u hdfs'
fi

${HDFS_COMMAND} hdfs dfs -mkdir -p /user/${USER_NAME}
${HDFS_COMMAND} hdfs dfs -chown ${USER_NAME} /user/${USER_NAME}
