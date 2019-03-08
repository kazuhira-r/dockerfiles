FROM openjdk:8-jdk-slim

ARG kafka_version=2.1.1
ARG kafka_scala_major_version=2.12
ARG kafka_home=/opt/apache-kafka

ARG kafka_distribution_url=http://ftp.riken.jp/net/apache/kafka/${kafka_version}/kafka_${kafka_scala_major_version}-${kafka_version}.tgz

ARG kafka_manager_version=1.3.3.22

ARG trifecta_version=0.22.0rc8
ARG trifecta_kafka_version=0.10.1.0
ARG trifecta_distribution_url=https://github.com/ldaniels528/trifecta/releases/download/v${trifecta_version}-${trifecta_kafka_version}/trifecta-ui-${trifecta_version}b-${trifecta_kafka_version}.zip

RUN apt-get update && \
    apt-get install -y sudo \
                       curl \
                       wget \
                       unzip \
                       vim && \
    apt-get clean

RUN adduser --disabled-login --gecos '' kafka && \
    usermod -G sudo kafka

RUN echo "Defaults:kafka !requiretty" >> /etc/sudoers.d/kafka && \
    echo "kafka ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/kafka && \
    chmod 440 /etc/sudoers.d/kafka

WORKDIR /opt
ADD kafka-manager-${kafka_manager_version}.zip kafka-manager-${kafka_manager_version}.zip
RUN cd /opt && \
    unzip kafka-manager-${kafka_manager_version}.zip && \
    mv kafka-manager-${kafka_manager_version} kafka-manager && \
    chown -R kafka.kafka kafka-manager-${kafka_manager_version}.zip kafka-manager

RUN cd /opt && \
    wget -q ${kafka_distribution_url} && \
    tar -zxf kafka_${kafka_scala_major_version}-${kafka_version}.tgz && \
    mv kafka_${kafka_scala_major_version}-${kafka_version} apache-kafka && \
    chown -R kafka.kafka /opt/apache-kafka kafka_${kafka_scala_major_version}-${kafka_version}.tgz && \
    wget -q ${trifecta_distribution_url} && \
    unzip trifecta-ui-${trifecta_version}b-${trifecta_kafka_version}.zip && \
    mv trifecta-ui-${trifecta_version}b-${trifecta_kafka_version} trifecta-ui && \
    chown -R kafka.kafka trifecta-ui

WORKDIR ${kafka_home}

ADD docker-entrypoint.sh docker-entrypoint.sh
RUN chown -R kafka.kafka docker-entrypoint.sh && \
    chmod a+x docker-entrypoint.sh

USER kafka

# for Apache Kafka
EXPOSE 2181 9092
# for kafka-manager/Trifecta
EXPOSE 9000

ENTRYPOINT ["/opt/apache-kafka/docker-entrypoint.sh"]
