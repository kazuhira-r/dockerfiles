FROM ubuntu:latest

ARG mailcatcher_version=0.6.5

RUN apt-get update -y && \
    apt-get install -y \
        sudo \
        vim \
        curl \
        wget \
        ruby-dev \
        build-essential \
        libsqlite3-dev

RUN gem install mailcatcher -v ${mailcatcher_version}

RUN adduser --disabled-login --gecos '' mailcatcher && \
    usermod -G sudo mailcatcher

RUN echo "Defaults:mailcatcher !requiretty" >> /etc/sudoers.d/mailcatcher && \
    echo "mailcatcher ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/mailcatcher && \
    chmod 440 /etc/sudoers.d/mailcatcher

USER mailcatcher
EXPOSE 1025 1080

ENTRYPOINT ["mailcatcher", "--no-quit", "--foreground", "--ip=0.0.0.0"]