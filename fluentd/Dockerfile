FROM ubuntu:latest

RUN apt-get update \
    && apt-get install -y sudo \
                       gnupg \
                       vim \
                       wget \
                       curl \
    && apt-get clean

RUN adduser --disabled-login --gecos '' fluentd-user \
    && usermod -G sudo fluentd-user

RUN echo "Defaults:fluentd-user !requiretty" >> /etc/sudoers.d/fluentd-user \
    && echo "fluentd-user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/fluentd-user \
    && chmod 440 /etc/sudoers.d/fluentd-user

RUN curl -L https://toolbelt.treasuredata.com/sh/install-ubuntu-bionic-td-agent3.sh | sh

USER fluentd-user

ENTRYPOINT sudo service td-agent start && tail -f /var/log/td-agent/td-agent.log
