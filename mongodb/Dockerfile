FROM ubuntu:18.04

ARG mongodb_major_version=4.4
ARG mongodb_version=4.4.0

EXPOSE 27017

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    sudo \
                    vim \
                    curl \
                    ca-certificates \
                    tzdata \
                    && \
    apt-get clean

RUN adduser --disabled-login --gecos '' mongo-user && \
    usermod -G sudo mongo-user

RUN echo "Defaults:mongo-user !requiretty" >> /etc/sudoers.d/mongo-user && \
    echo "mongo-user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/mongo-user && \
    chmod 440 /etc/sudoers.d/mongo-user

RUN curl -sL https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu1804-${mongodb_version}.tgz -o /opt/mongodb-linux-x86_64-ubuntu1804-${mongodb_version}.tgz && \
    cd /opt && \
    tar xf mongodb-linux-x86_64-ubuntu1804-${mongodb_version}.tgz && \
    mv mongodb-linux-x86_64-ubuntu1804-${mongodb_version} mongodb && \
    mkdir /opt/mongodb/conf && \
    curl -sL https://github.com/mongodb/mongo/raw/r${mongodb_version}/debian/mongod.conf -o /opt/mongodb/conf/mongod.conf && \
    mkdir /opt/mongodb/data && \
    mkdir /opt/mongodb/log && \
    chown -R mongo-user.mongo-user /opt/mongodb /opt/mongodb-linux-x86_64-ubuntu1804-${mongodb_version}.tgz

ADD docker-entrypoint.sh docker-entrypoint.sh

RUN chmod a+x docker-entrypoint.sh

USER mongo-user

ENTRYPOINT ["./docker-entrypoint.sh"] 
