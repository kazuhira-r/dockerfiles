FROM ubuntu:22.04

ARG redis_version=7.0.12
ARG redis_home=/opt/redis

WORKDIR ${redis_home}

RUN mkdir -p ${redis_home}

RUN cd /opt \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
                    sudo \
                    vim \
                    curl \
                    gcc \
                    g++ \
                    make \
    && apt-get clean \
    && curl -LO -s http://download.redis.io/releases/redis-${redis_version}.tar.gz \
    && tar -xf redis-${redis_version}.tar.gz \
    && mv redis-${redis_version} redis-src \
    && cd redis-src \
    && make \
    && make PREFIX=${redis_home} install

RUN adduser --disabled-login --gecos '' redis \
    && usermod -G sudo redis

RUN echo "Defaults:redis !requiretty" >> /etc/sudoers.d/redis \
    && echo "redis ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/redis \
    && chmod 440 /etc/sudoers.d/redis

RUN chown -R redis:redis ${redis_home} \
    && chown -R redis:redis /opt/redis-src

COPY docker-entrypoint.sh docker-entrypoint.sh
RUN chown -R redis:redis docker-entrypoint.sh \
    && chmod a+x docker-entrypoint.sh

USER redis

ENV REDIS_PASSWORD redispass

EXPOSE 6379

ENTRYPOINT ["/opt/redis/docker-entrypoint.sh"]
