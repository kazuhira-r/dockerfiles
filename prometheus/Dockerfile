FROM ubuntu:20.04

ARG prometheus_version=2.22.0

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
                    sudo \
                    vim \
                    curl \
                    ca-certificates \
                    && \
    apt-get clean

RUN adduser --disabled-login --gecos '' prometheus && \
    usermod -G sudo prometheus

RUN echo "Defaults:prometheus !requiretty" >> /etc/sudoers.d/prometheus && \
    echo "prometheus ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/prometheus && \
    chmod 440 /etc/sudoers.d/prometheus

RUN cd /opt && \
    curl -LO -s https://github.com/prometheus/prometheus/releases/download/v${prometheus_version}/prometheus-${prometheus_version}.linux-amd64.tar.gz && \
    tar xf prometheus-${prometheus_version}.linux-amd64.tar.gz && \
    mv prometheus-${prometheus_version}.linux-amd64 prometheus && \
    chown -R prometheus.prometheus prometheus
           
WORKDIR /opt/prometheus

EXPOSE 9090

USER prometheus

ENTRYPOINT ./prometheus && tail -f /dev/null
