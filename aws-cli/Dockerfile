FROM ubuntu:latest

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

USER aws-cli

RUN pip install awscli --upgrade --user

ENV PATH=~/.local/bin:$PATH

CMD echo "#####    AWS CLI upgrade command   #####\n  $ pip install awscli --upgrade --user\n\n    see: https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/installing.html\n########################################\n" && bash
