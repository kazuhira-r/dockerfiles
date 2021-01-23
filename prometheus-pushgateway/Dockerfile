FROM ubuntu:latest

ARG prometheus_pushgateway_version=0.8.0

RUN apt-get update && \
    apt-get install -y sudo \
                       curl \
                       wget \
                       vim && \
           apt-get clean

RUN adduser --disabled-login --gecos '' pushgateway && \
    usermod -G sudo pushgateway

RUN echo "Defaults:pushgateway !requiretty" >> /etc/sudoers.d/pushgateway && \
    echo "pushgateway ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/pushgateway && \
    chmod 440 /etc/sudoers.d/pushgateway

RUN cd /opt && \
    wget -q https://github.com/prometheus/pushgateway/releases/download/v${prometheus_pushgateway_version}/pushgateway-${prometheus_pushgateway_version}.linux-amd64.tar.gz && \
    tar xf pushgateway-${prometheus_pushgateway_version}.linux-amd64.tar.gz && \
    mv pushgateway-${prometheus_pushgateway_version}.linux-amd64 pushgateway && \
    chown -R pushgateway.pushgateway pushgateway
           
WORKDIR /opt/pushgateway

EXPOSE 9091

USER pushgateway

ENTRYPOINT ./pushgateway && tail -f /dev/null
