FROM ubuntu:latest

ARG nexus_major_version=3
ARG nexus_version=3.15.0-01

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

EXPOSE 8081
EXPOSE 8443

RUN apt-get update && \
    apt-get install -y openjdk-8-jdk \
                       sudo \
                       zip \
                       unzip \
                       wget \
                       curl \
                       vim && \
    apt-get clean

RUN adduser --disabled-login --gecos '' nexus && \
    usermod -G sudo nexus

RUN echo "Defaults:nexus !requiretty" >> /etc/sudoers.d/nexus && \
    echo "nexus ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/nexus && \
    chmod 440 /etc/sudoers.d/nexus

RUN cd /opt && \
    mkdir sonatype && \
    cd sonatype && \
    wget -q https://sonatype-download.global.ssl.fastly.net/nexus/${nexus_major_version}/nexus-${nexus_version}-unix.tar.gz && \
    tar -zxf nexus-${nexus_version}-unix.tar.gz && \
    mv nexus-${nexus_version} nexus && \
    mkdir /opt/sonatype/sonatype-work/nexus3/etc && \
    chown -R nexus.nexus /opt/sonatype


USER nexus
WORKDIR /opt/sonatype


## keystore password => password
## CN => my.nexus.repo.example.com
ADD keystore.jks /opt/sonatype/nexus/etc/ssl/keystore.jks

ADD nexus.properties /opt/sonatype/sonatype-work/nexus3/etc/nexus.properties

RUN perl -wpi -e 's!<Set name="KeyStorePassword">.+</Set>!<Set name="KeyStorePassword">password</Set>!' /opt/sonatype/nexus/etc/jetty/jetty-https.xml && \
    perl -wpi -e 's!<Set name="KeyManagerPassword">OBF:1v2j1uum1xtv1zej1zer1xtn1uvk1v1v</Set>!<Set name="KeyManagerPassword">password</Set>!' /opt/sonatype/nexus/etc/jetty/jetty-https.xml

ENTRYPOINT ["nexus/bin/nexus", "run"]

