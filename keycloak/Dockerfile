FROM eclipse-temurin:25-jdk-noble

ARG keycloak_version=26.7.1

ARG kc_bootstrap_admin_username=keycloak-admin
ARG kc_bootstrap_admin_password=password

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
    && curl -fsSL -O https://github.com/keycloak/keycloak/releases/download/${keycloak_version}/keycloak-${keycloak_version}.zip \
    && unzip keycloak-${keycloak_version}.zip \
    && mv keycloak-${keycloak_version} keycloak \
    && rm keycloak-${keycloak_version}.zip

WORKDIR /opt/keycloak

EXPOSE 8080

COPY docker-entrypoint.sh docker-entrypoint.sh
RUN chmod a+x docker-entrypoint.sh \
    && chown -R keycloak:keycloak /opt/keycloak

USER keycloak

RUN { \
    echo ''; \
    echo 'bootstrap-admin-username='${kc_bootstrap_admin_username}; \
    echo 'bootstrap-admin-password='${kc_bootstrap_admin_password}; \
    echo ''; \
    echo 'http-host=0.0.0.0'; \
    echo ''; \
    echo 'http-access-log-enabled=true'; \
} >> conf/keycloak.conf

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["start-dev"]
