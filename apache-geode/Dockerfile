FROM ubuntu:latest

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV GEODE_HOME /opt/apache-geode

ENV GEODE_VERSION 1.0.0-incubating.M1
ENV DISTRIBUTION_URL http://ftp.riken.jp/net/apache/incubator/geode/1.0.0-incubating.M1/apache-geode-${GEODE_VERSION}.tar.gz

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y oracle-java8-installer

RUN apt-get install -y wget \
                       curl \
                       vim

RUN cd /opt && \
    wget -q ${DISTRIBUTION_URL} && \
    tar -zxvf apache-geode-${GEODE_VERSION}.tar.gz && \
    ln -s apache-geode-${GEODE_VERSION} apache-geode && \
    ln -s ${GEODE_HOME}/bin/gfsh ${GEODE_HOME}/gfsh

WORKDIR ${GEODE_HOME}

# Default ports:
# RMI/JMX 1099
# REST 8080
# PULE 7070
# LOCATOR 10334
# CACHESERVER 40404
# REDIS 6379
# MEMCACHED 11211
EXPOSE 1099 6379 7070 8080 10334 11211 40404

ADD start_locator_and_server.sh start_locator_and_server.sh
RUN chmod a+x start_locator_and_server.sh

CMD ["bash"]
