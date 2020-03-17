FROM openjdk:11-jdk-slim
LABEL maintainer="kazuhira<kazuhira.m@gmail.com>"

ARG infinispan_version=10.1.5.Final

RUN apt-get update && \
    apt-get install -y sudo \
                       vim \
                       unzip \
                       curl \
                       && \
    apt-get clean

RUN adduser --disabled-login --gecos '' ispn && \
    usermod -G sudo ispn

RUN echo "Defaults:ispn !requiretty" >> /etc/sudoers.d/ispn && \
    echo "ispn ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/ispn && \
    chmod 440 /etc/sudoers.d/ispn

RUN cd /opt && \
    curl -L -O -s http://downloads.jboss.org/infinispan/${infinispan_version}/infinispan-server-${infinispan_version}.zip && \
    unzip infinispan-server-${infinispan_version}.zip && \
    # until 9.2.x...
    # curl -L -O -s http://downloads.jboss.org/infinispan/${infinispan_version}/infinispan-server-${infinispan_version}-bin.zip && \
    # unzip infinispan-server-${infinispan_version}-bin.zip && \
    mv infinispan-server-${infinispan_version} infinispan-server && \
    rm infinispan-server-${infinispan_version}.zip
    # until 9.2.x...
    # rm infinispan-server-${infinispan_version}-bin.zip

WORKDIR /opt/infinispan-server

EXPOSE 7800 8080 11222

ADD docker-entrypoint.sh docker-entrypoint.sh
RUN chmod a+x docker-entrypoint.sh

RUN chown -R ispn.ispn /opt/infinispan-server
USER ispn

ENTRYPOINT ["./docker-entrypoint.sh"]
