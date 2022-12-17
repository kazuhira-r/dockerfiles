FROM ubuntu:20.04

ARG prometheus_alertmanager_version=0.16.1

RUN apt-get update \
    && apt-get install -y sudo \
                       curl \
                       wget \
                       vim \
    && apt-get clean

RUN adduser --disabled-login --gecos '' alertmanager \
    && usermod -G sudo alertmanager

RUN echo "Defaults:alertmanager !requiretty" >> /etc/sudoers.d/alertmanager \
    && echo "alertmanager ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/alertmanager \
    && chmod 440 /etc/sudoers.d/alertmanager

RUN cd /opt \
    && wget -q https://github.com/prometheus/alertmanager/releases/download/v${prometheus_alertmanager_version}/alertmanager-${prometheus_alertmanager_version}.linux-amd64.tar.gz \
    && tar xf alertmanager-${prometheus_alertmanager_version}.linux-amd64.tar.gz \
    && mv alertmanager-${prometheus_alertmanager_version}.linux-amd64 alertmanager \
    && chown -R alertmanager:alertmanager alertmanager
           
WORKDIR /opt/alertmanager

EXPOSE 9093 9094

USER alertmanager

ENTRYPOINT ./alertmanager && tail -f /dev/null
