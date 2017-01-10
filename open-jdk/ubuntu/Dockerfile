FROM ubuntu:latest

RUN apt-get update -y && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y sudo \
                       wget \
                       curl \
                       vim && \
    apt-get clean

RUN adduser --disabled-password --gecos '' jdk-user && \
    echo jdk-user:password | chpasswd && \
    usermod -G sudo jdk-user

USER jdk-user

CMD bash
