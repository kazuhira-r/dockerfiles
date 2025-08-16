FROM ubuntu:24.04

ARG tempo_version=2.8.2

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                       sudo \
                       adduser \
                       curl \
                       ca-certificates \
                       vim \
                      ## systemdがないとtempoユーザーが作成されない
                       systemd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists*/

RUN adduser --disabled-login --gecos '' user \
    && usermod -G sudo user

RUN echo "Defaults:user !requiretty" >> /etc/sudoers.d/user \
    && echo "user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/user \
    && chmod 440 /etc/sudoers.d/user

RUN curl -fsSL -O https://github.com/grafana/tempo/releases/download/v${tempo_version}/tempo_${tempo_version}_linux_amd64.deb \
    && dpkg -i tempo_${tempo_version}_linux_amd64.deb \
    && rm tempo_${tempo_version}_linux_amd64.deb

EXPOSE 3200 4317 4318 9095
WORKDIR /home/user

USER user

ENTRYPOINT ["sudo", "-u", "tempo", "tempo", "-config.file", "/etc/tempo/config.yml"]
