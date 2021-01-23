FROM ubuntu:latest

ARG ubuntu_code_name=bionic
ARG varnish_version=varnish60lts

RUN apt-get update && \
    apt-get install -y sudo \
                       vim \
                       wget \
                       curl \
                       software-properties-common \
                       gnupg \
                       apt-transport-https \
                       && \
    apt-get clean

RUN adduser --disabled-login --gecos '' user && \
    usermod -G sudo user

RUN echo "Defaults:user !requiretty" >> /etc/sudoers.d/user && \
    echo "user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/user && \
    chmod 440 /etc/sudoers.d/user

RUN curl -sL https://packagecloud.io/varnishcache/varnish60lts/gpgkey | sudo apt-key add - && \
    add-apt-repository "deb https://packagecloud.io/varnishcache/${varnish_version}/ubuntu/ ${ubuntu_code_name} main" && \
    apt-get update && \
    apt-get install -y varnish

EXPOSE 6081 42573

USER user
WORKDIR /home/user

ADD start-varnish.sh start-varnish.sh
ADD stop-varnish.sh stop-varnish.sh

RUN sudo chown user.user start-varnish.sh stop-varnish.sh && \
    sudo chmod a+x start-varnish.sh stop-varnish.sh

ENTRYPOINT /home/user/start-varnish.sh && sudo -u varnish varnishncsa -F '%h %l %u %t "%r" %s %b "%{Referer}i" "%{User-agent}i" %{Varnish:hitmiss}x %{Varnish:handling}x'
