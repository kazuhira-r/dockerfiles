FROM ubuntu:20.04

## see, https://dev.mysql.com/downloads/repo/apt/
ARG mysql_apt_version=0.8.16-1

EXPOSE 3306

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    curl \
                    wget \
                    vim \
                    sudo \
                    gnupg \
                    lsb-release \
                    ca-certificates \
                    && \
    apt-get clean

RUN adduser --disabled-login --gecos '' user && \
    usermod -G sudo user

RUN echo "Defaults:user !requiretty" >> /etc/sudoers.d/user && \
    echo "user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/user && \
    chmod 440 /etc/sudoers.d/user

RUN curl -s -LO https://dev.mysql.com/get/mysql-apt-config_${mysql_apt_version}_all.deb && \
    echo 4 | dpkg -i mysql-apt-config_${mysql_apt_version}_all.deb

RUN sudo apt-get update && \
    # !!root password is ''!!
    # https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/#repo-qg-apt-repo-non-insteractive
    { \
      echo mysql-community-server mysql-community-server/root-pass password ''; \
      echo mysql-community-server mysql-community-server/re-root-pass password ''; \
    } | debconf-set-selections && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server && \
    apt-get clean

RUN cp -p /etc/mysql/mysql.cnf /etc/mysql/mysql.cnf.org
RUN cp -p /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf.org
COPY mysql.cnf /etc/mysql/mysql.cnf
COPY mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

COPY create-database-and-user.sh /home/user/create-database-and-user.sh
RUN chmod a+x /home/user/create-database-and-user.sh && chown user.user /home/user/create-database-and-user.sh

COPY setup-master.sh /home/user/setup-master.sh
RUN chmod a+x /home/user/setup-master.sh && chown user.user /home/user/setup-master.sh

COPY setup-slave.sh /home/user/setup-slave.sh
RUN chmod a+x /home/user/setup-slave.sh && chown user.user /home/user/setup-slave.sh

COPY setup-group-replication-initial-host.sh /home/user/setup-group-replication-initial-host.sh
RUN chmod a+x /home/user/setup-group-replication-initial-host.sh && chown user.user /home/user/setup-group-replication-initial-host.sh

COPY setup-group-replication-add-host.sh /home/user/setup-group-replication-add-host.sh
RUN chmod a+x /home/user/setup-group-replication-add-host.sh && chown user.user /home/user/setup-group-replication-add-host.sh

COPY docker-entrypoint.sh /home/user/docker-entrypoint.sh
RUN chmod a+x /home/user/docker-entrypoint.sh && chown user.user /home/user/docker-entrypoint.sh

COPY start-mysqld.sh /home/user/start-mysqld.sh
RUN chmod a+x /home/user/start-mysqld.sh && chown user.user /home/user/start-mysqld.sh

COPY connect-mysql-as-root.sh /home/user/connect-mysql-as-root.sh
RUN chmod a+x /home/user/connect-mysql-as-root.sh && chown user.user /home/user/connect-mysql-as-root.sh

USER user
WORKDIR /home/user

RUN echo '\n\
echo "*******************************************************\n\
login MySQL Server as root user.\n\
\n\
$ mysql -uroot -ppassword -h\`hostname -i\`\n\
\n\
*******************************************************\n\
"' >> /home/user/.bashrc

#ENTRYPOINT service mysql start && tail -f /dev/null 
#ENTRYPOINT ["/usr/sbin/mysqld"]
ENTRYPOINT ["sudo", "./docker-entrypoint.sh"]
