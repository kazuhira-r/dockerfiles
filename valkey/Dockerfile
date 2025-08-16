FROM ubuntu:24.04

ARG valkey_version=8.0.2
ARG valkey_home=/opt/valkey

WORKDIR ${valkey_home}

RUN mkdir -p ${valkey_home}

RUN cd /opt \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
                    sudo \
                    adduser \
                    passwd \
                    vim \
                    curl \
                    ca-certificates \
                    gcc \
                    g++ \
                    make \
                    pkgconf \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fsSL -O https://github.com/valkey-io/valkey/archive/refs/tags/${valkey_version}.tar.gz \
    && tar -xf ${valkey_version}.tar.gz \
    && cd valkey-${valkey_version} \
    && make \
    && make PREFIX=${valkey_home} install

RUN adduser --disabled-login --gecos '' valkey \
    && usermod -G sudo valkey

RUN echo "Defaults:valkey !requiretty" >> /etc/sudoers.d/valkey \
    && echo "valkey ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/valkey \
    && chmod 440 /etc/sudoers.d/valkey

RUN chown -R valkey:valkey ${valkey_home} \
    && chown -R valkey:valkey /opt/valkey-${valkey_version}

COPY valkey.conf conf/valkey.conf
RUN chown -R valkey:valkey conf/valkey.conf

COPY docker-entrypoint.sh docker-entrypoint.sh
RUN chown -R valkey:valkey docker-entrypoint.sh \
    && chmod a+x docker-entrypoint.sh

USER valkey

EXPOSE 6379

ENTRYPOINT ["/opt/valkey/docker-entrypoint.sh"]
