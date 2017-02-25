#!/bin/bash

set -e

/opt/apache-kafka/bin/zookeeper-server-start.sh -daemon config/zookeeper.properties
/opt/apache-kafka/bin/kafka-server-start.sh -daemon config/server.properties
/opt/trifecta-ui/bin/trifecta-ui &
tail -f /opt/apache-kafka/logs/kafkaServer.out /opt/apache-kafka/logs/zookeeper.out
