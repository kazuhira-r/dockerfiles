FROM ubuntu:latest

ARG smtp_cli_version=3.9

RUN apt-get update -y && \
           apt-get install -y sudo \
                                               vim \
                                               curl \
                                               wget \
                                               libio-socket-ssl-perl  \
                                               libdigest-hmac-perl  \
                                               libterm-readkey-perl \
                                               libmime-lite-perl \
                                               libfile-libmagic-perl \
                                               libio-socket-inet6-perl \
                                               && \
              apt-get clean

RUN adduser --disabled-login --gecos '' cli-user && \
           usermod -G sudo cli-user

RUN echo "Defaults:cli-user !requiretty" >> /etc/sudoers.d/cli-user && \
           echo "cli-user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/cli-user && \
           chmod 440 /etc/sudoers.d/cli-user

USER cli-user

WORKDIR /home/cli-user

RUN wget -q https://raw.githubusercontent.com/mludvig/smtp-cli/v${smtp_cli_version}/smtp-cli && \
           chmod a+x smtp-cli

ENTRYPOINT ["/bin/bash"]
