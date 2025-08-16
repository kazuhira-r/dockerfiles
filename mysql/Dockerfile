FROM ubuntu:24.04

## see, https://dev.mysql.com/downloads/repo/apt/
ARG mysql_apt_version=0.8.34-1
ARG mysql_version=mysql-8.4-lts
ARG root_password=password

EXPOSE 3306

ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:


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
    # !!root password is ''!!
    # https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/#repo-qg-apt-repo-non-insteractive
    && echo "mysql-community-server mysql-community-server/root-pass password ${root_password}" | sudo debconf-set-selections \
    && echo "mysql-community-server mysql-community-server/re-root-pass password ${root_password}" | sudo debconf-set-selections \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server mysql-shell \
    && apt-get clean

RUN cp -p /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf.org
COPY mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

COPY create-database-and-user.sh /home/user/create-database-and-user.sh
RUN chmod a+x /home/user/create-database-and-user.sh && chown user:user /home/user/create-database-and-user.sh

COPY setup-source.sh /home/user/setup-source.sh
RUN chmod a+x /home/user/setup-source.sh && chown user:user /home/user/setup-source.sh \
    && perl -wpi -e "s!%ROOT_PASSWORD%!${root_password}!" /home/user/setup-source.sh

COPY setup-replica.sh /home/user/setup-replica.sh
RUN chmod a+x /home/user/setup-replica.sh && chown user:user /home/user/setup-replica.sh \
    && perl -wpi -e "s!%ROOT_PASSWORD%!${root_password}!" /home/user/setup-replica.sh

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
$ mysqlsh root:${root_password}@localhost -S --sql\n\
\n\
*******************************************************\n\
"' >> /home/user/.bashrc

#ENTRYPOINT service mysql start && tail -f /dev/null 
#ENTRYPOINT ["/usr/sbin/mysqld"]
ENTRYPOINT ["sudo", "./docker-entrypoint.sh"]
