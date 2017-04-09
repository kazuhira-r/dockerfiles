FROM java:8

ARG wildfly_version=10.1.0.Final

RUN apt-get update && \
    apt-get install -y sudo \
                       vim \
                       && \
    apt-get clean

RUN adduser --disabled-password --gecos '' wildfly && \
    usermod -G sudo wildfly

RUN echo "Defaults:wildfly !requiretty" >> /etc/sudoers.d/wildfly && \
    echo "wildfly ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/wildfly && \
    chmod 440 /etc/sudoers.d/wildfly

RUN cd /opt && \
    wget -q http://download.jboss.org/wildfly/${wildfly_version}/wildfly-${wildfly_version}.zip && \
    unzip wildfly-${wildfly_version}.zip && \
    mv wildfly-${wildfly_version} wildfly && \
    chmod +x wildfly/bin/standalone.sh && \
    rm wildfly-${wildfly_version}.zip

WORKDIR /opt/wildfly

EXPOSE 8080 9990

ADD start-server.sh start-server.sh
RUN chmod a+x start-server.sh

ADD docker-entrypoint.sh docker-entrypoint.sh
RUN chmod a+x docker-entrypoint.sh

RUN chown -R wildfly.wildfly /opt/wildfly
USER wildfly

ENTRYPOINT ["./docker-entrypoint.sh"]
