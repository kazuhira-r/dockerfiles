FROM ubuntu:24.04

ARG otelcol_contrib_version=0.161.0

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                    sudo \
                    adduser \
                    vim \
                    curl \
                    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-login --gecos '' user \
    && usermod -G sudo user

RUN echo "Defaults:user !requiretty" >> /etc/sudoers.d/user \
    && echo "user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/user \
    && chmod 440 /etc/sudoers.d/user

RUN curl -fsSL -O https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v${otelcol_contrib_version}/otelcol-contrib_${otelcol_contrib_version}_linux_amd64.deb \
    && dpkg -i otelcol-contrib_${otelcol_contrib_version}_linux_amd64.deb

USER user

EXPOSE 1777 4317 4318 6831 6832 13133 14268 55690 55679

ENTRYPOINT ["sudo", "-u", "otelcol-contrib", "otelcol-contrib", "--config", "/etc/otelcol-contrib/config.yaml"]
