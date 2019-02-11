FROM ubuntu:latest

ARG keycloak_version=4.8.3.Final

RUN apt-get update -y && \
    apt-get install -y \
        sudo \
        vim \
        wget \
        curl

RUN adduser --disabled-login --gecos '' keycloak && \
    usermod -G sudo keycloak

RUN echo "Defaults:keycloak !requiretty" >> /etc/sudoers.d/keycloak && \
    echo "keycloak ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/keycloak && \
    chmod 440 /etc/sudoers.d/keycloak

RUN mkdir /opt/keycloak && \
    cd /opt/keycloak && \
    wget -q https://downloads.jboss.org/keycloak/${keycloak_version}/gatekeeper/keycloak-gatekeeper-linux-amd64.tar.gz && \
    tar xf keycloak-gatekeeper-linux-amd64.tar.gz && \
    chown -R keycloak.keycloak /opt/keycloak

USER keycloak
WORKDIR /opt/keycloak
EXPOSE 3000

ADD gatekeeper.yml gatekeeper.yml

CMD ["bash"]
