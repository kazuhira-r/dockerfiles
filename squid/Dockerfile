FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y sudo \
                       vim \
                       wget \
                       curl \
                       && \
    apt-get clean

RUN adduser --disabled-login --gecos '' user && \
    usermod -G sudo user

RUN echo "Defaults:user !requiretty" >> /etc/sudoers.d/user && \
    echo "user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/user && \
    chmod 440 /etc/sudoers.d/user

RUN apt-get install -y squid

EXPOSE 3182 8080

USER user
WORKDIR /home/user

ADD start-proxy.sh start-proxy.sh
ADD stop-proxy.sh stop-proxy.sh

RUN sudo chown user.user start-proxy.sh stop-proxy.sh && \
    sudo chmod a+x start-proxy.sh stop-proxy.sh

ENTRYPOINT sudo service squid start && sudo -u proxy touch /var/log/squid/access.log && sudo tail -f /var/log/squid/access.log
