FROM ubuntu:24.04

ARG grafana_version=12.1.1

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                       sudo \
                       adduser \
                       curl \
                       ca-certificates \
                       libfontconfig1 \
                       musl \
                       vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists*/

RUN adduser --disabled-login --gecos '' user \
    && usermod -G sudo user

RUN echo "Defaults:user !requiretty" >> /etc/sudoers.d/user \
    && echo "user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/user \
    && chmod 440 /etc/sudoers.d/user

RUN curl -fsSL -O https://dl.grafana.com/oss/release/grafana_${grafana_version}_amd64.deb \
    && dpkg -i grafana_${grafana_version}_amd64.deb \
    && rm grafana_${grafana_version}_amd64.deb

EXPOSE 3000
WORKDIR /home/user

COPY docker-entrypoint.sh docker-entrypoint.sh
RUN chmod +x docker-entrypoint.sh && chown user:user docker-entrypoint.sh

USER user

ENTRYPOINT ["./docker-entrypoint.sh"]
