FROM openjdk:8
LABEL maintainer="kazuhira<kazuhira.m@gmail.com>"

ARG infinispan_version=9.4.7.Final

RUN apt-get update && \
    apt-get install -y sudo \
                       vim \
                       && \
    apt-get clean

RUN adduser --disabled-login --gecos '' ispn && \
    usermod -G sudo ispn

RUN echo "Defaults:ispn !requiretty" >> /etc/sudoers.d/ispn && \
    echo "ispn ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/ispn && \
    chmod 440 /etc/sudoers.d/ispn

RUN cd /opt && \
    wget -q http://downloads.jboss.org/infinispan/${infinispan_version}/infinispan-server-${infinispan_version}.zip && \
    unzip infinispan-server-${infinispan_version}.zip && \
    # until 9.2.x...
    # wget -q http://downloads.jboss.org/infinispan/${infinispan_version}/infinispan-server-${infinispan_version}-bin.zip && \
    # unzip infinispan-server-${infinispan_version}-bin.zip && \
    mv infinispan-server-${infinispan_version} infinispan-server && \
    chmod +x infinispan-server/bin/standalone.sh && \
    rm infinispan-server-${infinispan_version}.zip
    # until 9.2.x...
    # rm infinispan-server-${infinispan_version}-bin.zip

WORKDIR /opt/infinispan-server

EXPOSE 8080 8181 9990 11211 11222

ADD docker-entrypoint.sh docker-entrypoint.sh
RUN chmod a+x docker-entrypoint.sh

RUN chown -R ispn.ispn /opt/infinispan-server
USER ispn

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["-c", "clustered.xml"]
