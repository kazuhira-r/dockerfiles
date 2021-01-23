FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y \
        sudo \
        wget \
        curl \
        vim \
        unzip \
        git \
        sysstat

RUN adduser --disabled-login --gecos '' user && \
    usermod -G sudo user

RUN echo "Defaults:user !requiretty" >> /etc/sudoers.d/user && \
    echo "user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/user && \
    chmod 440 /etc/sudoers.d/user

USER user
WORKDIR /home/user

CMD [ "bash" ]
