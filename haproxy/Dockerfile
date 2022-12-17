FROM ubuntu:20.04

RUN apt-get update \
    && apt-get install -y curl \
                       wget \
                       sudo \
                       vim \
    && apt-get install -y haproxy \
    && apt-get install -y rsyslog \
    && apt-get clean

RUN adduser --disabled-login --gecos '' user \
    && usermod -G sudo user

RUN echo "Defaults:user !requiretty" >> /etc/sudoers.d/user \
    && echo "user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/user \
    && chmod 440 /etc/sudoers.d/user

USER user

ENTRYPOINT sudo service rsyslog start && sudo service haproxy start && tail -f /dev/null
