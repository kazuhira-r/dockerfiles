#!/bin/bash

sh fix-hostname.sh

## Initialize HDFS.
sudo -u hdfs hdfs namenode -format

## Startup HDFS Process.
service hadoop-hdfs-namenode start
service hadoop-hdfs-datanode start
# service hadoop-hdfs-secondarynamenode start

## Startup Yarn Process.
service hadoop-yarn-resourcemanager start
service hadoop-yarn-nodemanager start

## create tmp directory.
sudo -u hdfs hdfs dfs -mkdir /tmp
sudo -u hdfs hdfs dfs -chmod 777 /tmp

service hadoop-mapreduce-historyserver start
