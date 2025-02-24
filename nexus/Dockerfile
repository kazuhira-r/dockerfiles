FROM eclipse-temurin:17.0.14_7-jdk-noble

ARG nexus_major_version=3
ARG nexus_version=3.77.1-01

EXPOSE 8081
EXPOSE 8443

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                       sudo \
                       unzip \
                       curl \
                       vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-login --gecos '' nexus \
    && usermod -G sudo nexus

RUN echo "Defaults:nexus !requiretty" >> /etc/sudoers.d/nexus \
    && echo "nexus ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/nexus \
    && chmod 440 /etc/sudoers.d/nexus

RUN cd /opt \
    && mkdir sonatype \
    && cd sonatype \
    && curl -sLO https://download.sonatype.com/nexus/${nexus_major_version}/nexus-${nexus_version}-unix.tar.gz \
    && tar -zxf nexus-${nexus_version}-unix.tar.gz \
    && mv nexus-${nexus_version} nexus \
    && mkdir /opt/sonatype/sonatype-work/nexus3/etc \
    && chown -R nexus:nexus /opt/sonatype

USER nexus
WORKDIR /opt/sonatype

## keystore password => password
## CN => my.nexus.repo.example.com
COPY keystore.jks /opt/sonatype/nexus/etc/ssl/keystore.jks
COPY nexus.properties /opt/sonatype/sonatype-work/nexus3/etc/nexus.properties

RUN perl -wpi -e 's!<Set name="KeyStorePassword">.+</Set>!<Set name="KeyStorePassword">password</Set>!' /opt/sonatype/nexus/etc/jetty/jetty-https.xml \
    && perl -wpi -e 's!<Set name="KeyManagerPassword">OBF:1v2j1uum1xtv1zej1zer1xtn1uvk1v1v</Set>!<Set name="KeyManagerPassword">password</Set>!' /opt/sonatype/nexus/etc/jetty/jetty-https.xml

ENTRYPOINT ["nexus/bin/nexus", "run"]
