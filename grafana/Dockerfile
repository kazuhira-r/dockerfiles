FROM ubuntu:24.04

ARG grafana_version=12.0.2+security~01

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                       sudo \
                       curl \
                       adduser \
                       libfontconfig1 \
                       musl \
                       ca-certificates \
                       vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists*/

RUN curl -sLO https://dl.grafana.com/oss/release/grafana_${grafana_version}_amd64.deb \
    && dpkg -i grafana_${grafana_version}_amd64.deb \
    && rm grafana_${grafana_version}_amd64.deb

RUN adduser --disabled-login --gecos '' grafana-user \
    && usermod -G sudo grafana-user \
    && usermod -G grafana grafana-user

RUN echo "Defaults:grafana-user !requiretty" >> /etc/sudoers.d/grafana-user \
    && echo "grafana-user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/grafana-user \
    && chmod 440 /etc/sudoers.d/grafana-user

EXPOSE 3000

COPY docker-entrypoint.sh docker-entrypoint.sh
RUN chmod +x docker-entrypoint.sh

USER grafana-user

ENTRYPOINT ["./docker-entrypoint.sh"]
