FROM eclipse-temurin:17-jdk-focal

ARG keycloak_version=19.0.2

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    sudo \
                    unzip \
                    vim \
                    curl \
                    jq \
                    && \
    apt-get clean

RUN adduser --disabled-login --gecos '' keycloak && \
    usermod -G sudo keycloak

RUN echo "Defaults:keycloak !requiretty" >> /etc/sudoers.d/keycloak && \
    echo "keycloak ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/keycloak && \
    chmod 440 /etc/sudoers.d/keycloak

RUN cd /opt && \
    curl -s -LO https://github.com/keycloak/keycloak/releases/download/${keycloak_version}/keycloak-${keycloak_version}.zip && \
    unzip keycloak-${keycloak_version}.zip && \
    mv keycloak-${keycloak_version} keycloak && \
    rm keycloak-${keycloak_version}.zip

WORKDIR /opt/keycloak

EXPOSE 8080

ENV KEYCLOAK_ADMIN admin
ENV KEYCLOAK_ADMIN_PASSWORD password

ADD docker-entrypoint.sh docker-entrypoint.sh
RUN chmod a+x docker-entrypoint.sh

RUN chown -R keycloak:keycloak /opt/keycloak
USER keycloak

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["start-dev"]
