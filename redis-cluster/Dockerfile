FROM ubuntu:latest

ARG redis_version=3.2.6
ARG redis_home=/opt/redis

WORKDIR ${redis_home}

RUN mkdir -p ${redis_home}

RUN apt-get update

RUN apt-get install -y apt-file && \
    apt-file update && \
    apt-file search add-apt-repository && \
    apt-get install -y software-properties-common

RUN apt-add-repository ppa:brightbox/ruby-ng && \
    apt-get update && \                      
    apt-get install -y ruby2.2

RUN gem install redis

RUN cd /opt && \
    apt-get install -y \
     wget \
     gcc \
     make \
     && \
    wget -q http://download.redis.io/releases/redis-${redis_version}.tar.gz && \
    tar -zxvf redis-${redis_version}.tar.gz && \
    mv redis-${redis_version} redis-src && \
    cd redis-src && \
    make && \
    make PREFIX=${redis_home} install

EXPOSE 6379

RUN mkdir conf

ADD redis.conf.template conf/redis.conf.template
ADD start-redis.sh start-redis.sh

RUN chmod a+x start-redis.sh

ENTRYPOINT ["./start-redis.sh"]
