FROM eclipse-temurin:17-jdk-jammy

ARG trino_version=395

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                    sudo \
                    vim \
                    curl \
                    unzip \
                    ca-certificates \
                    less \
                    python3 \
                    python-is-python3 \
    && apt-get clean

RUN adduser --disabled-login --gecos '' trino \
    && usermod -G sudo trino

RUN echo "Defaults:trino !requiretty" >> /etc/sudoers.d/trino \
    && echo "trino ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/trino \
    && chmod 440 /etc/sudoers.d/trino

RUN curl -s -L https://repo1.maven.org/maven2/io/trino/trino-cli/${trino_version}/trino-cli-${trino_version}-executable.jar -o /usr/local/bin/trino \
    && chmod +x /usr/local/bin/trino

RUN cd /opt \
    && curl -s -LO https://repo1.maven.org/maven2/io/trino/trino-server/${trino_version}/trino-server-${trino_version}.tar.gz \
    && tar xf trino-server-${trino_version}.tar.gz \
    && mv trino-server-${trino_version} trino-server \
    && chown -R trino:trino trino-server

RUN mkdir -p /var/lib/trino-server/data \
    && chown -R trino:trino /var/lib/trino-server

EXPOSE 8080

WORKDIR /opt/trino-server

RUN mkdir etc
COPY etc/node.properties etc/node.properties
COPY etc/jvm.config etc/jvm.config
COPY etc/config.properties etc/config.properties

RUN chown -R trino:trino etc

COPY docker-entrypoint.sh docker-entrypoint.sh
RUN chmod a+x docker-entrypoint.sh && chown trino:trino docker-entrypoint.sh

USER trino

ENTRYPOINT ["./docker-entrypoint.sh"]

