FROM ubuntu:24.04

ARG nexus_major_version=3
ARG nexus_version=3.82.0-08

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                       sudo \
                       adduser \
                       unzip \
                       curl \
                       ca-certificates \
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
    && curl -sLO https://download.sonatype.com/nexus/${nexus_major_version}/nexus-${nexus_version}-linux-x86_64.tar.gz \
    && tar xz --keep-directory-symlink -f nexus-${nexus_version}-linux-x86_64.tar.gz \
    && mv nexus-${nexus_version} nexus \
    && rm nexus-${nexus_version}-linux-x86_64.tar.gz

RUN cd /opt/sonatype/sonatype-work/nexus3 \
  && mkdir -p etc/ssl \
  && $(find ../../nexus/jdk -name keytool) -genkeypair \
      -keystore etc/ssl/keystore.jks \
      -storepass password \
      -alias nexus.example.com \
      -keyalg RSA \
      -keysize 2048 \
      -validity 3650 \
      -dname 'CN=nexus.example.com, OU=Unit, O=Company, L=City, S=State, C=Country' \
  && echo 'nexus-args=${jetty.etc}/jetty.xml,${jetty.etc}/jetty-http.xml,${jetty.etc}/jetty-https.xml,${jetty.etc}/jetty-requestlog.xml' >> etc/nexus.properties \
  && echo 'application-port-ssl=8443' >> etc/nexus.properties \
  && echo 'ssl.etc=${karaf.data}/etc/ssl' >> etc/nexus.properties

RUN chown -R nexus:nexus /opt/sonatype

USER nexus
WORKDIR /opt/sonatype

EXPOSE 8081
EXPOSE 8443

ENTRYPOINT ["bash", "nexus/bin/nexus", "run"]
