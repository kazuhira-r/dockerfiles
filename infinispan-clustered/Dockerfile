FROM java:8
MAINTAINER kazuhira<kazuhira.m@gmail.com>

ENV INFINISPAN_VERSION 9.0.0.Alpha4

WORKDIR /opt

RUN adduser --disabled-password --gecos '' ispn

RUN wget -q http://downloads.jboss.org/infinispan/$INFINISPAN_VERSION/infinispan-server-$INFINISPAN_VERSION-bin.zip && \
    unzip infinispan-server-$INFINISPAN_VERSION-bin.zip && \
    mv infinispan-server-$INFINISPAN_VERSION infinispan-server && \
    chmod +x infinispan-server/bin/standalone.sh && \
    rm infinispan-server-$INFINISPAN_VERSION-bin.zip

WORKDIR /opt/infinispan-server

RUN perl -wpi -e 's/-Xms\d+[a-z]/-Xms1g/g; s/-Xmx\d+[a-z]/-Xmx1g/g' bin/standalone.conf*

EXPOSE 8080 8181 9990 11211 11222

ADD start-clustered-server.sh start-clustered-server.sh
RUN chmod a+x start-clustered-server.sh

RUN chown -R ispn.ispn /opt/infinispan-server
USER ispn

ENTRYPOINT ["./start-clustered-server.sh"]
