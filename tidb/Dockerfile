FROM ubuntu:22.04

## see, https://dev.mysql.com/downloads/repo/apt/
ARG mysql_apt_version=0.8.30-1
ARG mysql_version=mysql-8.0

ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:

ENV ROOT_PASSWORD=password

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                    curl \
                    wget \
                    vim \
                    sudo \
                    gnupg \
                    lsb-release \
                    ca-certificates \
                    language-pack-en \
                    language-pack-ja \
                    tzdata \
    && apt-get clean

RUN adduser --disabled-login --gecos '' user \
    && usermod -G sudo user

RUN echo "Defaults:user !requiretty" >> /etc/sudoers.d/user \
    && echo "user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/user \
    && chmod 440 /etc/sudoers.d/user

RUN update-locale LANG=ja_JP.UTF-8 LANGUAGE=ja_JP:

RUN curl -s -LO https://dev.mysql.com/get/mysql-apt-config_${mysql_apt_version}_all.deb \
    && echo "mysql-apt-config mysql-apt-config/select-server select ${mysql_version}" | debconf-set-selections \
    && DEBIAN_FRONTEND=noninteractive dpkg -i mysql-apt-config_${mysql_apt_version}_all.deb

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-client mysql-shell \
    && apt-get clean

COPY create-database-and-user.sh /home/user/create-database-and-user.sh
RUN chmod a+x /home/user/create-database-and-user.sh && chown user:user /home/user/create-database-and-user.sh

USER user
WORKDIR /home/user

RUN curl --proto '=https' --tlsv1.2 -sSf https://tiup-mirrors.pingcap.com/install.sh | sh

ENV PATH=/home/user/.tiup/bin:${PATH}

EXPOSE 2397 3000 4000 9090

CMD ["bash"]
