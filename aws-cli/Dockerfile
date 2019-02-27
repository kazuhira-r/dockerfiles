FROM ubuntu:latest

ARG node_version=v10.15.1

RUN apt-get update -y && \
    apt-get install -y python \
                       groff \
                       curl \
                       wget \
                       sudo \
                       vim \
                       unzip \
                       && \
    apt-get clean

RUN adduser --disabled-login --gecos '' aws-cli && \
    usermod -G sudo aws-cli

RUN echo "Defaults:aws-cli !requiretty" >> /etc/sudoers.d/aws-cli && \
    echo "aws-cli ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/aws-cli && \
    chmod 440 /etc/sudoers.d/aws-cli

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

RUN cd /opt && \
    wget -q https://nodejs.org/dist/${node_version}/node-${node_version}-linux-x64.tar.xz && \
    tar xf node-${node_version}-linux-x64.tar.xz && \
    mv node-${node_version}-linux-x64 node && \
    chown -R aws-cli.aws-cli /opt/node

USER aws-cli

RUN pip install awscli --upgrade --user
RUN PATH=/opt/node/bin:${PATH} npm i -g aws-sam-local

ENV PATH=~/.local/bin:/opt/node/bin:$PATH

CMD echo "#####    AWS CLI upgrade command   #####\n  $ pip install awscli --upgrade --user\n\n    see: https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/installing.html\n########################################\n" && bash
