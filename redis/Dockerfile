FROM ubuntu:latest

ENV REDIS_VERSION 3.0.6
ENV REDIS_HOME /opt/redis

WORKDIR ${REDIS_HOME}

RUN mkdir -p ${REDIS_HOME}

RUN apt-get update

RUN cd /opt && \
    apt-get install -y \
     wget \
     gcc \
     make \
     && \
    wget -q http://download.redis.io/releases/redis-${REDIS_VERSION}.tar.gz && \
    tar -zxvf redis-${REDIS_VERSION}.tar.gz && \
    mv redis-${REDIS_VERSION} redis-src && \
    cd redis-src && \
    make && \
    make PREFIX=${REDIS_HOME} install

EXPOSE 6379

ENTRYPOINT ["/opt/redis/bin/redis-server"]
