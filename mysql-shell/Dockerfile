FROM ubuntu:20.04

## see, https://dev.mysql.com/downloads/repo/apt/
ARG mysql_apt_version=0.8.16-1

EXPOSE 3306

ENV LANG ja_JP.UTF-8
ENV LANGUAGE=ja_JP: 

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    curl \
                    wget \
                    vim \
                    sudo \
                    gnupg \
                    lsb-release \
                    ca-certificates \
                    language-pack-ja \
                    tzdata \
                    && \
    apt-get clean

RUN adduser --disabled-login --gecos '' user && \
    usermod -G sudo user

RUN echo "Defaults:user !requiretty" >> /etc/sudoers.d/user && \
    echo "user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/user && \
    chmod 440 /etc/sudoers.d/user

RUN update-locale LANG=ja_JP.UTF-8 LANGUAGE=ja_JP:

RUN curl -s -LO https://dev.mysql.com/get/mysql-apt-config_${mysql_apt_version}_all.deb && \
    echo 4 | dpkg -i mysql-apt-config_${mysql_apt_version}_all.deb

RUN apt-get update && \
    apt-get install -y mysql-client mysql-shell && \
    apt-get clean

USER user

CMD bash
