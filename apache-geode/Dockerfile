FROM ubuntu:latest

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

ARG geode_version=1.3.0

## since Apache Geode 1.3.0, tar.gz to tgz
ARG geode_distribution_url=http://ftp.meisei-u.ac.jp/mirror/apache/dist/geode/${geode_version}/apache-geode-${geode_version}.tgz
#ARG geode_distribution_url=https://archive.apache.org/dist/incubator/geode/${geode_version}/apache-geode-${geode_version}.tgz

## until Apache Geode 1.2.1
#ARG geode_distribution_url=http://ftp.meisei-u.ac.jp/mirror/apache/dist/geode/${geode_version}/apache-geode-${geode_version}.tar.gz
#ARG geode_distribution_url=https://archive.apache.org/dist/incubator/geode/${geode_version}/apache-geode-${geode_version}.tar.gz

RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y sudo \
                       curl \
                       wget \
                       vim && \
    apt-get clean

RUN adduser --disabled-password --gecos '' geode && \
    usermod -G sudo geode

RUN echo "Defaults:geode !requiretty" >> /etc/sudoers.d/geode && \
    echo "geode ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/geode && \
    chmod 440 /etc/sudoers.d/geode

RUN cd /opt && \
    wget -q ${geode_distribution_url} && \
    tar -zxf apache-geode-${geode_version}.tgz && \
    # tar -zxf apache-geode-${geode_version}.tar.gz && \
    mv apache-geode-${geode_version} apache-geode && \
    chown -R geode.geode /opt/apache-geode apache-geode-${geode_version}.tgz
    # chown -R geode.geode /opt/apache-geode apache-geode-${geode_version}.tar.gz

USER geode
WORKDIR /opt/apache-geode

EXPOSE 8080 10334 40404 1099 7070

CMD ["bin/gfsh"]
