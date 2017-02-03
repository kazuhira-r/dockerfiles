FROM ubuntu:latest

ARG redis_version=3.2.7
ARG redis_home=/opt/redis

RUN adduser --disabled-password --gecos '' redis

WORKDIR ${redis_home}

RUN mkdir -p ${redis_home}

RUN apt-get update

RUN cd /opt && \
    apt-get install -y \
     wget \
     gcc \
     make && \
    apt-get clean && \
    wget -q http://download.redis.io/releases/redis-${redis_version}.tar.gz && \
    tar -zxvf redis-${redis_version}.tar.gz && \
    mv redis-${redis_version} redis-src && \
    cd redis-src && \
    make && \
    make PREFIX=${redis_home} install

RUN chown -R redis.redis ${redis_home} && \
    chown -R redis.redis /opt/redis-src

USER redis

EXPOSE 6379

ENTRYPOINT ["/opt/redis/bin/redis-server", "--protected-mode", "no"]
