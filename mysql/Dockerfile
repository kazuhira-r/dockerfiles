FROM ubuntu:26.04

## see, https://dev.mysql.com/downloads/repo/apt/
ARG mysql_apt_version=0.8.40-1
ARG mysql_version=mysql-9.7-lts

EXPOSE 3306

ENV LANG=ja_JP.UTF-8


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
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-login --gecos '' user \
    && usermod -G sudo user

RUN echo "Defaults:user !requiretty" >> /etc/sudoers.d/user \
    && echo "user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/user \
    && chmod 440 /etc/sudoers.d/user

RUN update-locale LANG=ja_JP.UTF-8 LANGUAGE=ja_JP:

RUN curl -fsSL -O https://dev.mysql.com/get/mysql-apt-config_${mysql_apt_version}_all.deb \
    && echo "mysql-apt-config mysql-apt-config/select-server select ${mysql_version}" | debconf-set-selections \
    && DEBIAN_FRONTEND=noninteractive dpkg -i mysql-apt-config_${mysql_apt_version}_all.deb

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server mysql-shell \
    && apt-get clean

RUN cp -p /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf.org
COPY mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

COPY create-database-and-user.sh /home/user/create-database-and-user.sh
RUN chmod a+x /home/user/create-database-and-user.sh && chown user:user /home/user/create-database-and-user.sh

COPY setup-source.sh /home/user/setup-source.sh
RUN chmod a+x /home/user/setup-source.sh && chown user:user /home/user/setup-source.sh

COPY setup-replica.sh /home/user/setup-replica.sh
RUN chmod a+x /home/user/setup-replica.sh && chown user:user /home/user/setup-replica.sh

COPY setup-group-replication-initial-host.sh /home/user/setup-group-replication-initial-host.sh
RUN chmod +x /home/user/setup-group-replication-initial-host.sh && chown user:user /home/user/setup-group-replication-initial-host.sh

COPY setup-group-replication-add-host.sh /home/user/setup-group-replication-add-host.sh
RUN chmod a+x /home/user/setup-group-replication-add-host.sh && chown user:user /home/user/setup-group-replication-add-host.sh

COPY docker-entrypoint.sh /home/user/docker-entrypoint.sh
RUN chmod a+x /home/user/docker-entrypoint.sh && chown user:user /home/user/docker-entrypoint.sh

COPY restart-mysqld.sh /home/user/restart-mysqld.sh
RUN chmod a+x /home/user/restart-mysqld.sh && chown user:user /home/user/restart-mysqld.sh

USER user
WORKDIR /home/user

RUN echo '\n\
echo "*******************************************************\n\
login MySQL Server as root user.\n\
\n\
$ sudo mysqlsh --socket=/var/run/mysqld/mysqld.sock --no-password\n\
\n\
*******************************************************\n\
"' >> /home/user/.bashrc

#ENTRYPOINT service mysql start && tail -f /dev/null 
#ENTRYPOINT ["/usr/sbin/mysqld"]
ENTRYPOINT ["sudo", "./docker-entrypoint.sh"]
