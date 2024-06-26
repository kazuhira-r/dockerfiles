FROM eclipse-temurin:21-jdk-jammy
LABEL maintainer="kazuhira<kazuhira.m@gmail.com>"

ARG infinispan_version=15.0.4.Final

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                    sudo \
                    unzip \
                    vim \
                    curl \
    && apt-get clean

RUN adduser --disabled-login --gecos '' ispn \
    && usermod -G sudo ispn

RUN echo "Defaults:ispn !requiretty" >> /etc/sudoers.d/ispn \
    && echo "ispn ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/ispn \
    && chmod 440 /etc/sudoers.d/ispn

WORKDIR /opt

RUN curl -L -O -s https://downloads.jboss.org/infinispan/${infinispan_version}/infinispan-server-${infinispan_version}.zip \
   && unzip infinispan-server-${infinispan_version}.zip \
    # until 9.2.x...
    # && curl -L -O -s http://downloads.jboss.org/infinispan/${infinispan_version}/infinispan-server-${infinispan_version}-bin.zip \
    # && unzip infinispan-server-${infinispan_version}-bin.zip \
    && mv infinispan-server-${infinispan_version} infinispan-server \
    && rm infinispan-server-${infinispan_version}.zip \
    # until 9.2.x...
    # && rm infinispan-server-${infinispan_version}-bin.zip \
    && chown -R ispn:ispn /opt/infinispan-server

WORKDIR /opt/infinispan-server

EXPOSE 7800 11222

COPY docker-entrypoint.sh docker-entrypoint.sh
RUN chmod a+x docker-entrypoint.sh

COPY restart.sh restart.sh
RUN chmod a+x restart.sh

USER ispn

ENTRYPOINT ["./docker-entrypoint.sh"]
