FROM ubuntu:latest

ARG mailhog_version=v1.0.0

RUN apt-get update && \
    apt-get install -y \
        sudo \
        vim \
        wget \
        curl

RUN adduser --disabled-login --gecos '' mailhog && \
    usermod -G sudo mailhog

RUN echo "Defaults:mailhog !requiretty" >> /etc/sudoers.d/mailhog && \
    echo "mailhog ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/mailhog && \
    chmod 440 /etc/sudoers.d/mailhog

RUN mkdir /opt/mailhog && \
    cd /opt/mailhog && \
    wget -q https://github.com/mailhog/MailHog/releases/download/${mailhog_version}/MailHog_linux_amd64 && \
    chown -R mailhog:mailhog /opt/mailhog && \
    chmod a+x MailHog_linux_amd64

USER mailhog
WORKDIR /opt/mailhog
EXPOSE 1025 8025

ENTRYPOINT [ "/opt/mailhog/MailHog_linux_amd64" ]
