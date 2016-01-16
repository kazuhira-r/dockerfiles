FROM ubuntu:latest

ENV REDIS_VERSION 3.0.6
ENV REDIS_HOME /opt/redis

WORKDIR ${REDIS_HOME}

RUN mkdir -p ${REDIS_HOME}

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
    wget -q http://download.redis.io/releases/redis-${REDIS_VERSION}.tar.gz && \
    tar -zxvf redis-${REDIS_VERSION}.tar.gz && \
    mv redis-${REDIS_VERSION} redis-src && \
    cd redis-src && \
    make && \
    make PREFIX=${REDIS_HOME} install

EXPOSE 6379

RUN mkdir conf

ADD redis.conf.template conf/redis.conf.template
ADD start-redis.sh start-redis.sh

RUN chmod a+x start-redis.sh

ENTRYPOINT ["./start-redis.sh"]
