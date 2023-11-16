FROM eclipse-temurin:17-jdk-jammy

ARG wildfly_version=30.0.0.Final

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                       sudo \
                       unzip \
                       vim \
                       curl \
    && apt-get clean

RUN adduser --disabled-login --gecos '' wildfly \
    && usermod -G sudo wildfly

RUN echo "Defaults:wildfly !requiretty" >> /etc/sudoers.d/wildfly \
    && echo "wildfly ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/wildfly \
    && chmod 440 /etc/sudoers.d/wildfly

RUN cd /opt \
    && curl -OLs https://github.com/wildfly/wildfly/releases/download/${wildfly_version}/wildfly-${wildfly_version}.zip \
    && unzip wildfly-${wildfly_version}.zip \
    && mv wildfly-${wildfly_version} wildfly \
    && chmod +x wildfly/bin/standalone.sh \
    && rm wildfly-${wildfly_version}.zip

WORKDIR /opt/wildfly

EXPOSE 8080 9990

COPY start-server.sh start-server.sh
RUN chmod a+x start-server.sh

COPY docker-entrypoint.sh docker-entrypoint.sh
RUN chmod a+x docker-entrypoint.sh

RUN chown -R wildfly:wildfly /opt/wildfly
USER wildfly

ENTRYPOINT ["./docker-entrypoint.sh"]
