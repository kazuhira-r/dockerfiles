FROM ubuntu:latest

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

ARG geode_version=1.2.0

ARG geode_distribution_url=http://ftp.meisei-u.ac.jp/mirror/apache/dist/geode/${geode_version}/apache-geode-${geode_version}.tar.gz
#ARG geode_distribution_url=https://archive.apache.org/dist/incubator/geode/${geode_version}/apache-geode-${geode_version}.tar.gz

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y oracle-java8-installer && \
    apt-get install -y sudo \
                       curl \
                       vim && \
    apt-get clean

RUN adduser --disabled-password --gecos '' geode && \
    usermod -G sudo geode

RUN echo "Defaults:geode !requiretty" >> /etc/sudoers.d/geode && \
    echo "geode ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/geode && \
    chmod 440 /etc/sudoers.d/geode

RUN cd /opt && \
    wget -q ${geode_distribution_url} && \
    tar -zxf apache-geode-${geode_version}.tar.gz && \
    mv apache-geode-${geode_version} apache-geode && \
    chown -R geode.geode /opt/apache-geode apache-geode-${geode_version}.tar.gz

USER geode
WORKDIR /opt/apache-geode

EXPOSE 8080 10334 40404 1099 7070

CMD ["bin/gfsh"]
