FROM ubuntu:24.04

ARG duckdb_version=1.4.1

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                    sudo \
                    adduser \
                    vim \
                    curl \
                    unzip \
                    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists*

RUN adduser --disabled-login --gecos '' duckdb \
    && usermod -G sudo duckdb

RUN echo "Defaults:duckdb !requiretty" >> /etc/sudoers.d/duckdb \
    && echo "duckdb ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/duckdb \
    && chmod 440 /etc/sudoers.d/duckdb

RUN curl -fsSL -O https://github.com/duckdb/duckdb/releases/download/v${duckdb_version}/duckdb_cli-linux-amd64.gz \
    && gunzip duckdb_cli-linux-amd64.gz \
    && mv duckdb_cli-linux-amd64 /usr/local/bin/duckdb \
    && chmod +x /usr/local/bin/duckdb

USER duckdb
WORKDIR /home/duckdb

ENTRYPOINT ["duckdb"]
