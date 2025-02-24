FROM eclipse-temurin:21-jdk-noble

ARG keycloak_version=26.0.7

ENV KEYCLOAK_ADMIN keycloak-admin
ENV KEYCLOAK_ADMIN_PASSWORD password

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                    sudo \
                    unzip \
                    vim \
                    curl \
                    jq \
                    less \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-login --gecos '' keycloak \
    && usermod -G sudo keycloak

RUN echo "Defaults:keycloak !requiretty" >> /etc/sudoers.d/keycloak \
    && echo "keycloak ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/keycloak \
    && chmod 440 /etc/sudoers.d/keycloak

RUN cd /opt \
    && curl -s -LO https://github.com/keycloak/keycloak/releases/download/${keycloak_version}/keycloak-${keycloak_version}.zip \
    && unzip keycloak-${keycloak_version}.zip \
    && mv keycloak-${keycloak_version} keycloak \
    && rm keycloak-${keycloak_version}.zip

WORKDIR /opt/keycloak

EXPOSE 8080

COPY docker-entrypoint.sh docker-entrypoint.sh
COPY conf/quarkus.properties conf/quarkus.properties
RUN chmod a+x docker-entrypoint.sh \
    && chown -R keycloak:keycloak /opt/keycloak

USER keycloak

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["start-dev"]
