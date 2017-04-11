FROM ubuntu:latest

RUN apt-get update -y && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y sudo \
                       wget \
                       curl \
                       vim && \
    apt-get clean

RUN adduser --disabled-password --gecos '' jdk-user && \
    usermod -G sudo jdk-user

RUN echo "Defaults:jdk-user !requiretty" >> /etc/sudoers.d/jdk-user && \
    echo "jdk-user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/jdk-user && \
    chmod 440 /etc/sudoers.d/jdk-user

USER jdk-user

CMD bash
