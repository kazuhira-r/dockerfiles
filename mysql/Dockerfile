FROM ubuntu:latest

## see, https://dev.mysql.com/downloads/repo/apt/
ENV MYSQL_APT_VERSION 0.7.3-1

EXPOSE 3306

RUN apt-get update && \
    apt-get install -y wget \
                       curl \
                       vim \
                       sudo \
                       lsb-release

RUN wget https://dev.mysql.com/get/mysql-apt-config_${MYSQL_APT_VERSION}_all.deb && \
    echo 4 | dpkg -i mysql-apt-config_${MYSQL_APT_VERSION}_all.deb

RUN sudo apt-get update && \
    # !!root password is ''!!
    { \
      echo mysql-community-server mysql-community-server/root-pass password ''; \
      echo mysql-community-server mysql-community-server/re-root-pass password ''; \
    } | debconf-set-selections && \
    apt-get update && \
    apt-get install -y mysql-server

ADD mysql.cnf /etc/mysql/mysql.cnf
ADD mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

ADD create-database-and-user.sh create-database-and-user.sh
RUN chmod a+x create-database-and-user.sh

ENTRYPOINT service mysql start && tail -f /dev/null 
