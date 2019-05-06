FROM ubuntu:latest

ARG terraform_version=0.11.13

RUN apt-get update -y && \
    apt-get install -y sudo \
                       curl \
                       wget \
                       unzip \
                       vim && \
           apt-get clean

RUN adduser --disabled-login --gecos '' terraform && \
    usermod -G sudo terraform

RUN echo "Defaults:terraform !requiretty" >> /etc/sudoers.d/terraform && \
    echo "terraform ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/terraform && \
    chmod 440 /etc/sudoers.d/terraform

RUN cd /tmp && \
    wget -q https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip && \
    unzip terraform_${terraform_version}_linux_amd64.zip && \
    mv terraform /usr/local/bin

WORKDIR /home/terraform
USER terraform

CMD [ "bash" ]
