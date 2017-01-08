FROM ubuntu:latest

ENV NEXUS_MAJOR_VERSION 3
ENV NEXUS_VERSION 3.2.0-01

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

EXPOSE 8081
EXPOSE 8443

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y oracle-java8-installer && \
    apt-get install -y sudo \
                       zip \
                       unzip \
                       wget \
                       curl \
                       vim && \
    apt-get clean

RUN adduser --disabled-password --gecos '' nexus && \
    echo nexus:password | chpasswd && \
    usermod -G sudo nexus

RUN cd /opt && \
    mkdir sonatype && \
    cd sonatype && \
    wget -q https://sonatype-download.global.ssl.fastly.net/nexus/${NEXUS_MAJOR_VERSION}/nexus-${NEXUS_VERSION}-unix.tar.gz && \
    tar -zxf nexus-${NEXUS_VERSION}-unix.tar.gz && \
    mv nexus-${NEXUS_VERSION} nexus && \
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
