FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y vim \
                       sudo \
                       curl \
                       wget \
                       python3-pip \
                       && \
    apt-get clean

RUN adduser --disabled-login --gecos '' locust && \
    usermod -G sudo locust

RUN echo "Defaults:locust !requiretty" >> /etc/sudoers.d/locust && \
    echo "locust ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/locust && \
    chmod 440 /etc/sudoers.d/locust

USER locust
WORKDIR /home/locust

RUN python3 -m pip install locustio

ENTRYPOINT sudo su - locust
