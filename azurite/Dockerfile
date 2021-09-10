FROM node:14-bullseye

ARG azurite_version=3.14.2

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    sudo \
                    vim \
                    curl \
                    ca-certificates \
                    && \
    apt-get clean

RUN adduser --disabled-login --gecos '' azurite && \
    usermod -G sudo azurite

RUN echo "Defaults:azurite !requiretty" >> /etc/sudoers.d/azurite && \
    echo "azurite ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/azurite && \
    chmod 440 /etc/sudoers.d/azurite

RUN mkdir -p /opt/azurite/data && \
    chown -R azurite.azurite /opt/azurite && \
    cd /opt/azurite && \
    sudo -u azurite npm i azurite@${azurite_version}

EXPOSE 10000 10001 10002

USER azurite

WORKDIR /opt/azurite

ENTRYPOINT ["npx", "azurite", "--blobHost", "0.0.0.0", "-l", "data"]
