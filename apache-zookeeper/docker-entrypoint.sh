#!/bin/bash

set -e

CONFIG=$(cat <<'EOS'
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/var/lib/apache-zookeeper
clientPort=2181
EOS
)

echo "${CONFIG}" > conf/zoo.cfg

bin/zkServer.sh start

tail -f logs/zookeeper.out
