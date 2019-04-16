FROM ubuntu:latest

RUN apt-get update -y && \
    apt-get install -y python3-pip \
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

USER aws-cli

RUN pip3 install awscli --upgrade --user
RUN pip3 install awslogs

ENV PATH=~/.local/bin:$PATH

CMD echo "#####    AWS CLI upgrade command   #####\n  $ pip install awscli --upgrade --user\n\n    see: https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/installing.html\n########################################\n" && bash

