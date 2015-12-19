#!/bin/bash

## create tmp directory.
sudo -u hdfs hdfs dfs -mkdir /tmp
sudo -u hdfs hdfs dfs -chmod 777 /tmp

## create yarn log directory.
sudo -u hdfs hdfs dfs -mkdir -p /var/log/hadoop-yarn
sudo -u hdfs hdfs dfs -chown yarn /var/log/hadoop-yarn
