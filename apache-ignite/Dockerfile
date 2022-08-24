FROM openjdk:8-jdk-slim

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

ARG ignite_version=2.7.0

ARG ignite_distribution_url=http://ftp.meisei-u.ac.jp/mirror/apache/dist//ignite/${ignite_version}/apache-ignite-${ignite_version}-bin.zip

RUN apt-get update && \
    apt-get install -y sudo \
                       curl \
                       wget \
                       vim \
                       unzip && \
    apt-get clean

RUN adduser --disabled-login --gecos '' ignite && \
    usermod -G sudo ignite

RUN echo "Defaults:ignite !requiretty" >> /etc/sudoers.d/ignite && \
    echo "ignite ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/ignite && \
    chmod 440 /etc/sudoers.d/ignite

RUN cd /opt && \
    wget -q ${ignite_distribution_url} && \
    unzip apache-ignite-${ignite_version}-bin.zip && \
    mv apache-ignite-${ignite_version}-bin apache-ignite-bin && \
    chown -R ignite:ignite /opt/apache-ignite-bin apache-ignite-${ignite_version}-bin.zip

ADD docker-entrypoint.sh /opt/apache-ignite-bin/docker-entrypoint.sh
RUN chmod a+x /opt/apache-ignite-bin/docker-entrypoint.sh && \
           chown ignite:ignite /opt/apache-ignite-bin/docker-entrypoint.sh

USER ignite
WORKDIR /opt/apache-ignite-bin

EXPOSE 10800 11211 33153 35434 47100 47500 49112

ENTRYPOINT ["/opt/apache-ignite-bin/docker-entrypoint.sh"]
