#!/bin/bash

set -e

ENABLE_ZOOKEEPER=1
ENABLE_KAFKA_SERVER=1
ZOOKEEPER_CONNECT=localhost:2181

ENABLE_TRIFECTA=0
ENABLE_KAFKA_MANAGER=0

while getopts c:mstz OPTION
do
    case $OPTION in
        c)
            ZOOKEEPER_CONNECT=${OPTARG};;
        m)
            ENABLE_KAFKA_MANAGER=1;;
        s)
            ENABLE_KAFKA_SERVER=0;;
        t)
            ENABLE_TRIFECTA=1;;
        z)
            ENABLE_ZOOKEEPER=0;;
        \?)
            echo 'unknown option'
            exit 1;;
    esac
done

TAIL_LOG=

if [ ${ENABLE_ZOOKEEPER} -eq 1 ]; then
    if [ ! -d /opt/apache-kafka/logs ]; then
        mkdir /opt/apache-kafka/logs
    fi

    touch /opt/apache-kafka/logs/zookeeper.out
    TAIL_LOG="${TAIL_LOG} /opt/apache-kafka/logs/zookeeper.out"

    /opt/apache-kafka/bin/zookeeper-server-start.sh -daemon config/zookeeper.properties
fi

if [ ${ENABLE_KAFKA_SERVER} -eq 1 ]; then
    SERVER_ADDRESS=`hostname -i`
    AUTO_BROKER_ID=`echo ${SERVER_ADDRESS} | perl -wp -e 's!.+\.(\d+)!$1!'`

    perl -wpi -e 's!^#listeners=PLAINTEXT://:9092!listeners=PLAINTEXT://'${SERVER_ADDRESS}':9092!' config/server.properties
    perl -wpi -e 's!zookeeper.connect=.+!zookeeper.connect='${ZOOKEEPER_CONNECT}'!' config/server.properties
    perl -wpi -e 's!broker.id=.+!broker.id='${AUTO_BROKER_ID}'!' config/server.properties

    if [ ! -d /opt/apache-kafka/logs ]; then
        mkdir /opt/apache-kafka/logs
    fi

    touch /opt/apache-kafka/logs/kafkaServer.out
    TAIL_LOG="${TAIL_LOG} /opt/apache-kafka/logs/kafkaServer.out"

    /opt/apache-kafka/bin/kafka-server-start.sh -daemon config/server.properties
fi

if [ ${ENABLE_TRIFECTA} -eq 1 ]; then
    /opt/trifecta-ui/bin/trifecta-ui &
fi

if [ ${ENABLE_KAFKA_MANAGER} -eq 1 ]; then
    /opt/kafka-manager/bin/kafka-manager -Dkafka-manager.zkhosts=${ZOOKEEPER_CONNECT} &
fi

tail -f ${TAIL_LOG}
