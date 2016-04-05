FROM java:8
MAINTAINER kazuhira<kazuhira.m@gmail.com>

ENV INFINISPAN_VERSION 8.2.1.Final

RUN mkdir -p /opt/infinispan

WORKDIR /opt/infinispan

RUN wget -q http://downloads.jboss.org/infinispan/$INFINISPAN_VERSION/infinispan-server-$INFINISPAN_VERSION-bin.zip && \
    unzip infinispan-server-$INFINISPAN_VERSION-bin.zip && \
    mv infinispan-server-$INFINISPAN_VERSION infinispan-server && \
    chmod +x infinispan-server/bin/standalone.sh

RUN perl -wpi -e 's/-Xms\d+[a-z]/-Xms1g/g; s/-Xmx\d+[a-z]/-Xmx1g/g' infinispan-server/bin/standalone.conf*

EXPOSE 8080 8181 9990 11211 11222

ADD start-clustered-server.sh start-clustered-server.sh
RUN chmod a+x start-clustered-server.sh

ENTRYPOINT ["./start-clustered-server.sh"]
