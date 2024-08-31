FROM eclipse-temurin:21-jdk-jammy

ARG keycloak_version=25.0.4

ENV KEYCLOAK_ADMIN admin
ENV KEYCLOAK_ADMIN_PASSWORD password

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                    sudo \
                    unzip \
                    vim \
                    curl \
                    jq \
                    less \
    && apt-get clean

RUN adduser --disabled-login --gecos '' keycloak \
    && usermod -G sudo keycloak

RUN echo "Defaults:keycloak !requiretty" >> /etc/sudoers.d/keycloak \
    && echo "keycloak ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/keycloak \
    && chmod 440 /etc/sudoers.d/keycloak

RUN cd /opt \
    && curl -s -LO https://github.com/keycloak/keycloak/releases/download/${keycloak_version}/keycloak-${keycloak_version}.zip \
    && unzip keycloak-${keycloak_version}.zip \
    && mv keycloak-${keycloak_version} keycloak \
    && rm keycloak-${keycloak_version}.zip \
    && chown -R keycloak:keycloak /opt/keycloak

WORKDIR /opt/keycloak

EXPOSE 8080

COPY docker-entrypoint.sh docker-entrypoint.sh
RUN chmod a+x docker-entrypoint.sh

USER keycloak

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["start-dev"]
