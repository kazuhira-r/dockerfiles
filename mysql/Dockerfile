FROM ubuntu:latest

## see, https://dev.mysql.com/downloads/repo/apt/
ARG mysql_apt_version=0.8.12-1

EXPOSE 3306

RUN apt-get update && \
    apt-get install -y wget \
                       curl \
                       vim \
                       sudo \
                       gnupg \
                       lsb-release

RUN wget https://dev.mysql.com/get/mysql-apt-config_${mysql_apt_version}_all.deb && \
    echo 4 | dpkg -i mysql-apt-config_${mysql_apt_version}_all.deb

RUN sudo apt-get update && \
    # !!root password is ''!!
    # https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/#repo-qg-apt-repo-non-insteractive
    { \
      echo mysql-community-server mysql-community-server/root-pass password ''; \
      echo mysql-community-server mysql-community-server/re-root-pass password ''; \
    } | debconf-set-selections && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server

RUN cp -p /etc/mysql/mysql.cnf /etc/mysql/mysql.cnf.org
RUN cp -p /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf.org
ADD mysql.cnf /etc/mysql/mysql.cnf
ADD mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

ADD create-database-and-user.sh create-database-and-user.sh
RUN chmod a+x create-database-and-user.sh

ADD setup-master.sh setup-master.sh
RUN chmod a+x setup-master.sh

ADD setup-slave.sh setup-slave.sh
RUN chmod a+x setup-slave.sh

ADD setup-group-replication-initial-host.sh setup-group-replication-initial-host.sh
RUN chmod a+x setup-group-replication-initial-host.sh

ADD setup-group-replication-add-host.sh setup-group-replication-add-host.sh
RUN chmod a+x setup-group-replication-add-host.sh

ADD docker-entrypoint.sh docker-entrypoint.sh
RUN chmod a+x docker-entrypoint.sh

#ENTRYPOINT service mysql start && tail -f /dev/null 
#ENTRYPOINT ["/usr/sbin/mysqld"]
ENTRYPOINT ["./docker-entrypoint.sh"]
