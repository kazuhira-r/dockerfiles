FROM ubuntu:24.04

ARG prometheus_version=3.5.0

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                    sudo \
                    adduser \
                    vim \
                    curl \
                    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-login --gecos '' prometheus \
    && usermod -G sudo prometheus

RUN echo "Defaults:prometheus !requiretty" >> /etc/sudoers.d/prometheus \
    && echo "prometheus ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/prometheus \
    && chmod 440 /etc/sudoers.d/prometheus

RUN cd /opt \
    && curl -fsSL -O https://github.com/prometheus/prometheus/releases/download/v${prometheus_version}/prometheus-${prometheus_version}.linux-amd64.tar.gz \
    && tar xf prometheus-${prometheus_version}.linux-amd64.tar.gz \
    && mv prometheus-${prometheus_version}.linux-amd64 prometheus \
    && chown -R prometheus:prometheus prometheus
           
WORKDIR /opt/prometheus

EXPOSE 9090

USER prometheus

ENTRYPOINT ["./prometheus"]
