FROM ubuntu:latest

ENV MONGODB_VERSION 3.2.10

EXPOSE 27017

RUN apt-get -y update && \
    apt-get install -y wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists

RUN adduser --disabled-password --gecos '' mongodb

RUN cd /opt && \
    wget -q https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-${MONGODB_VERSION}.tgz && \
    tar -zxf mongodb-linux-x86_64-${MONGODB_VERSION}.tgz && \
    rm mongodb-linux-x86_64-${MONGODB_VERSION}.tgz && \
    mv mongodb-linux-x86_64-${MONGODB_VERSION} mongodb && \
    mkdir -p /data/db && \
    chown -R mongodb.mongodb /opt/mongodb /data

USER mongodb

WORKDIR /opt/mongodb

ENTRYPOINT bin/mongod
