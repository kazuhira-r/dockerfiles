#!/bin/bash

KAFKA_MANAGER_VERSION=1.3.3.17

wget -q https://github.com/yahoo/kafka-manager/archive/${KAFKA_MANAGER_VERSION}.tar.gz
tar -zxf ${KAFKA_MANAGER_VERSION}.tar.gz
cd kafka-manager-${KAFKA_MANAGER_VERSION}

./sbt clean dist

mv target/universal/kafka-manager-${KAFKA_MANAGER_VERSION}.zip ../
cd ..
rm -rf ${KAFKA_MANAGER_VERSION}.tar.gz kafka-manager-${KAFKA_MANAGER_VERSION}
