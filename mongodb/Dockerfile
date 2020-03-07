FROM ubuntu:latest

ARG mongodb_major_version=4.2
ARG mongodb_version=4.2.3

EXPOSE 27017

RUN apt-get -y update && \
    apt-get install -y sudo \
                       wget \
                       vim \
                       curl \
                       gnupg \
                       && \
    apt-get clean

RUN adduser --disabled-login --gecos '' mongo-user && \
    usermod -G sudo mongo-user

RUN echo "Defaults:mongo-user !requiretty" >> /etc/sudoers.d/mongo-user && \
    echo "mongo-user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/mongo-user && \
    chmod 440 /etc/sudoers.d/mongo-user

RUN wget -qO - https://www.mongodb.org/static/pgp/server-${mongodb_major_version}.asc | apt-key add - && \
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/${mongodb_major_version} multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-${mongodb_major_version}.list && \
    apt-get update -y && \
    apt-get install -y mongodb-org-server=${mongodb_version} \
                       mongodb-org-shell=${mongodb_version} \
                       mongodb-org-tools=${mongodb_version} \
                       mongodb-org-mongos=${mongodb_version} \
                       && \
    apt-get clean

ADD docker-entrypoint.sh docker-entrypoint.sh

RUN chmod a+x docker-entrypoint.sh

USER mongo-user

ENTRYPOINT ["./docker-entrypoint.sh"] 
