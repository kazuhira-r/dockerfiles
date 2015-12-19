#!/bin/bash

sh fix-hostname.sh $1

## Initialize HDFS.
sudo -u hdfs hdfs namenode -format

## Startup HDFS Process.
sh start-hdfs.sh

## Create HDFS Initial Directries.
sh init-hdfs-directories.sh

## Startup Yarn Process.
# sh start-yarn.sh
