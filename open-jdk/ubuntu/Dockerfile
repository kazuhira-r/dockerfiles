FROM ubuntu:latest

RUN apt-get update -y && \
    apt-get install -y openjdk-8-jdk

RUN adduser --disabled-password --gecos '' jdk-user

USER jdk-user

CMD bash
