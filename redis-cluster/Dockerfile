FROM ubuntu:latest

ARG redis_version=5.0.8
ARG redis_home=/opt/redis

WORKDIR ${redis_home}

RUN mkdir -p ${redis_home}

RUN cd /opt && \
    apt-get update && \
    apt-get install -y vim \
                       sudo \
                       curl \
                       gcc \
                       make && \
    apt-get clean && \
    curl -OL -s http://download.redis.io/releases/redis-${redis_version}.tar.gz && \
    tar -xf redis-${redis_version}.tar.gz && \
    mv redis-${redis_version} redis-src && \
    cd redis-src && \
    make && \
    make PREFIX=${redis_home} install

RUN adduser --disabled-login --gecos '' redis && \
    usermod -G sudo redis

RUN echo "Defaults:redis !requiretty" >> /etc/sudoers.d/redis && \
    echo "redis ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/redis && \
    chmod 440 /etc/sudoers.d/redis

RUN chown -R redis.redis ${redis_home} && \
    chown -R redis.redis /opt/redis-src

RUN mkdir conf

ADD redis.conf.template conf/redis.conf.template
ADD docker-entrypoint.sh docker-entrypoint.sh
RUN chown -R redis.redis docker-entrypoint.sh conf conf/redis.conf.template && \
    chmod a+x docker-entrypoint.sh

RUN chmod a+x docker-entrypoint.sh

USER redis

EXPOSE 6379 16379

ENTRYPOINT ["/opt/redis/docker-entrypoint.sh"]
