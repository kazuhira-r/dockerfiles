FROM java:8
MAINTAINER kazuhira<kazuhira.m@gmail.com>

ARG infinispan_version=9.0.1.Final

RUN apt-get update && \
    apt-get install -y sudo \
                       vim \
                       && \
    apt-get clean

RUN adduser --disabled-password --gecos '' ispn && \
    usermod -G sudo ispn

RUN echo "Defaults:ispn !requiretty" >> /etc/sudoers.d/ispn && \
    echo "ispn ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/ispn && \
    chmod 440 /etc/sudoers.d/ispn

RUN cd /opt && \
    wget -q http://downloads.jboss.org/infinispan/${infinispan_version}/infinispan-server-${infinispan_version}-bin.zip && \
    unzip infinispan-server-${infinispan_version}-bin.zip && \
    mv infinispan-server-${infinispan_version} infinispan-server && \
    chmod +x infinispan-server/bin/standalone.sh && \
    rm infinispan-server-${infinispan_version}-bin.zip

WORKDIR /opt/infinispan-server

RUN perl -wpi -e 's/-Xms\d+[a-z]/-Xms1g/g; s/-Xmx\d+[a-z]/-Xmx1g/g' bin/standalone.conf*

EXPOSE 8080 8181 9990 11211 11222

ADD start-clustered-server.sh start-clustered-server.sh
RUN chmod a+x start-clustered-server.sh

ADD docker-entrypoint.sh docker-entrypoint.sh
RUN chmod a+x docker-entrypoint.sh

RUN chown -R ispn.ispn /opt/infinispan-server
USER ispn

ENTRYPOINT ["./docker-entrypoint.sh"]
