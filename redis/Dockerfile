FROM ubuntu:latest

ENV REDIS_VERSION 3.2.5
ENV REDIS_HOME /opt/redis

RUN adduser --disabled-password --gecos '' redis

WORKDIR ${REDIS_HOME}

RUN mkdir -p ${REDIS_HOME}

RUN apt-get update

RUN cd /opt && \
    apt-get install -y \
     wget \
     gcc \
     make && \
    apt-get clean && \
    wget -q http://download.redis.io/releases/redis-${REDIS_VERSION}.tar.gz && \
    tar -zxvf redis-${REDIS_VERSION}.tar.gz && \
    mv redis-${REDIS_VERSION} redis-src && \
    cd redis-src && \
    make && \
    make PREFIX=${REDIS_HOME} install

RUN chown -R redis.redis ${REDIS_HOME} && \
    chown -R redis.redis /opt/redis-src

USER redis

EXPOSE 6379

ENTRYPOINT ["/opt/redis/bin/redis-server"]
