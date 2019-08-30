FROM ubuntu:latest

## see, https://dev.mysql.com/downloads/repo/apt/
ARG mysql_apt_version=0.8.13-1

EXPOSE 3306

RUN apt-get update && \
    apt-get install -y wget \
                       curl \
                       vim \
                       sudo \
                       gnupg \
                       lsb-release

RUN adduser --disabled-login --gecos '' user && \
    usermod -G sudo user

RUN echo "Defaults:user !requiretty" >> /etc/sudoers.d/user && \
    echo "user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/user && \
    chmod 440 /etc/sudoers.d/user

RUN wget https://dev.mysql.com/get/mysql-apt-config_${mysql_apt_version}_all.deb && \
    echo 4 | dpkg -i mysql-apt-config_${mysql_apt_version}_all.deb

RUN sudo apt-get update && \
    apt-get install -y mysql-client mysql-shell

USER user

CMD bash
