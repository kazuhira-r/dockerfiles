FROM ubuntu:latest

ARG redis_version=4.0.11
ARG redis_home=/opt/redis

RUN adduser --disabled-login --gecos '' redis

WORKDIR ${redis_home}

RUN mkdir -p ${redis_home}

RUN cd /opt && \
          apt-get update -y && \
          apt-get install -y wget \
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

ADD docker-entrypoint.sh docker-entrypoint.sh
RUN chown -R redis.redis docker-entrypoint.sh && \
           chmod a+x docker-entrypoint.sh

USER redis

EXPOSE 6379

ENTRYPOINT ["/opt/redis/docker-entrypoint.sh"]
