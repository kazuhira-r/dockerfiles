#!/bin/bash

export HADOOP_HOME=/opt/hadoop

AWS_SDK_JAR=$(find ${HADOOP_HOME}/share/hadoop/tools/lib -name 'aws-java-sdk-bundle-*.jar')
HADOOP_AWS_JAR=$(find ${HADOOP_HOME}/share/hadoop/tools/lib -name 'hadoop-aws-*.jar')

export HADOOP_CLASSPATH=${AWS_SDK_JAR}:${HADOOP_AWS_JAR}

perl -wp -i -e 's!thrift://localhost:9083!thrift://0.0.0.0:9083!' conf/metastore-site.xml

bin/schematool -initSchema -dbType derby
bin/start-metastore
