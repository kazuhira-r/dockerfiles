FROM ubuntu:latest

# see: https://dl.bintray.com/rabbitmq/debian/pool/rabbitmq-server/
ARG rabbitmq_version=3.7.17-1

EXPOSE 5672 25672

RUN apt-get update && \
    apt-get install -y wget \
                       curl \
                       vim \
                       sudo \
                       gnupg

RUN adduser --disabled-login --gecos '' user && \
    usermod -G sudo user

RUN echo "Defaults:user !requiretty" >> /etc/sudoers.d/user && \
    echo "user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/user && \
    chmod 440 /etc/sudoers.d/user

RUN curl -fsSL https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc | apt-key add - && \
    apt-key adv --keyserver "hkps.pool.sks-keyservers.net" --recv-keys "0x6B73A36E6026DFCA" && \
    echo "deb http://dl.bintray.com/rabbitmq-erlang/debian bionic erlang" | tee /etc/apt/sources.list.d/bintray.erlang.list && \
    echo "deb https://dl.bintray.com/rabbitmq/debian bionic main" | tee /etc/apt/sources.list.d/bintray.rabbitmq.list

RUN apt-get update && \
    apt-get install -y erlang-nox rabbitmq-server=${rabbitmq_version} && \
    apt-get clean

RUN rabbitmq-plugins enable rabbitmq_management

USER user
WORKDIR /home/user

ADD add-user.sh add-user.sh
RUN sudo chown user:user add-user.sh && \
    chmod a+x add-user.sh

ENTRYPOINT sudo service rabbitmq-server start && tail -f /dev/null
