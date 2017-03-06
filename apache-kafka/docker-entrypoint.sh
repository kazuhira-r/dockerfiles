#!/bin/bash

set -e

SERVER_ADDRESS=`hostname -i`

perl -wpi -e 's!^#listeners=PLAINTEXT://:9092!listeners=PLAINTEXT://'${SERVER_ADDRESS}':9092!' config/server.properties

/opt/apache-kafka/bin/zookeeper-server-start.sh -daemon config/zookeeper.properties
/opt/apache-kafka/bin/kafka-server-start.sh -daemon config/server.properties
/opt/trifecta-ui/bin/trifecta-ui &
tail -f /opt/apache-kafka/logs/kafkaServer.out /opt/apache-kafka/logs/zookeeper.out
