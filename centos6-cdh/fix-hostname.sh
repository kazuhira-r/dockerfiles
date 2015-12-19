#!/bin/bash

if [ "$1" == "" ]; then
    TARGET_HOSTNAME=$HOSTNAME
else
    TARGET_HOSTNAME=$1
fi

# fix hostname
sed -ri s/localhost/$TARGET_HOSTNAME/ /etc/hadoop/conf.mine/core-site.xml
sed -ri s/localhost/$TARGET_HOSTNAME/ /etc/hadoop/conf.mine/hdfs-site.xml
sed -ri s/localhost/$TARGET_HOSTNAME/ /etc/hadoop/conf.mine/mapred-site.xml
sed -ri s/localhost/$TARGET_HOSTNAME/ /etc/hadoop/conf.mine/yarn-site.xml
