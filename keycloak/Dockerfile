FROM java:8

ARG keycloak_version=4.0.0.Final

RUN apt-get update && \
           apt-get install -y sudo \
                                              vim \
                                              && \
           apt-get clean

RUN adduser --disabled-password --gecos '' keycloak && \
          usermod -G sudo keycloak

RUN echo "Defaults:keycloak !requiretty" >> /etc/sudoers.d/keycloak && \
          echo "keycloak ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/keycloak && \
          chmod 440 /etc/sudoers.d/keycloak

RUN cd /opt && \
          wget -q https://downloads.jboss.org/keycloak/${keycloak_version}/keycloak-${keycloak_version}.zip && \
          unzip keycloak-${keycloak_version}.zip && \
          mv keycloak-${keycloak_version} keycloak && \
          chmod +x keycloak/bin/standalone.sh && \
          rm keycloak-${keycloak_version}.zip

WORKDIR /opt/keycloak

EXPOSE 8080 9990

ADD start-server.sh start-server.sh
RUN chmod a+x start-server.sh

ADD docker-entrypoint.sh docker-entrypoint.sh
RUN chmod a+x docker-entrypoint.sh

RUN chown -R keycloak.keycloak /opt/keycloak
USER keycloak

ENTRYPOINT ["./docker-entrypoint.sh"]
