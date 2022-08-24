FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    sudo \
                    unzip \
                    vim \
                    curl \
                    ca-certificates \
                    less \
                    && \
    apt-get clean

RUN adduser --disabled-login --gecos '' aws-cli && \
    usermod -G sudo aws-cli

RUN echo "Defaults:aws-cli !requiretty" >> /etc/sudoers.d/aws-cli && \
    echo "aws-cli ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/aws-cli && \
    chmod 440 /etc/sudoers.d/aws-cli

RUN curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip -u awscliv2.zip && \
    aws/install

RUN curl -s "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb" && \
    dpkg -i session-manager-plugin.deb

COPY docker-entrypoint.sh docker-entrypoint.sh

RUN chown aws-cli:aws-cli docker-entrypoint.sh && \
    chmod a+x docker-entrypoint.sh

USER aws-cli

CMD ["./docker-entrypoint.sh"] 
