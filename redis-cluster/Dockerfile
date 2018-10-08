FROM ubuntu:latest

ARG redis_version=4.0.11
ARG redis_home=/opt/redis

WORKDIR ${redis_home}

RUN mkdir -p ${redis_home}

RUN apt-get update

RUN apt-get update -y && \
           apt-get install -y apt-file && \
           apt-file update && \
           apt-file search add-apt-repository && \
           apt-get install -y software-properties-common \
                                               wget \
                                               gcc \
                                               make \
                                               ruby && \
           apt-get clean

RUN gem install redis

RUN cd /opt && \
           wget -q http://download.redis.io/releases/redis-${redis_version}.tar.gz && \
           tar -zxvf redis-${redis_version}.tar.gz && \
           mv redis-${redis_version} redis-src && \
           cd redis-src && \
           make && \
           make PREFIX=${redis_home} install

EXPOSE 6379

RUN mkdir conf

ADD redis.conf.template conf/redis.conf.template
ADD docker-entrypoint.sh docker-entrypoint.sh

RUN chmod a+x docker-entrypoint.sh

ENTRYPOINT ["./docker-entrypoint.sh"]
