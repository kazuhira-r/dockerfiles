FROM ubuntu:latest

ARG grafana_version=5.4.3

RUN apt-get update && \
    apt-get install -y sudo \
                       curl \
                       wget \
#                      gnupg \
                       libfontconfig \
                       vim && \
    apt-get clean

RUN wget -q https://dl.grafana.com/oss/release/grafana_${grafana_version}_amd64.deb && \
    dpkg -i grafana_${grafana_version}_amd64.deb && \
    rm grafana_${grafana_version}_amd64.deb

#RUN echo 'deb https://packagecloud.io/grafana/stable/debian/ stretch main' >> /etc/apt/sources.list && \
#    curl https://packagecloud.io/gpg.key | apt-key add - && \
#    apt-get update && \
#    apt-get install -y grafana

RUN adduser --disabled-login --gecos '' grafana-user && \
    usermod -G sudo grafana-user && \
    usermod -G grafana grafana-user

RUN echo "Defaults:grafana-user !requiretty" >> /etc/sudoers.d/grafana-user && \
    echo "grafana-user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/grafana-user && \
    chmod 440 /etc/sudoers.d/grafana-user

EXPOSE 3000

USER grafana-user

ENTRYPOINT sudo service grafana-server start && sudo tail -f /var/log/grafana/grafana.log
