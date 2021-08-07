FROM ubuntu:20.04

ARG cockroachdb_version=v21.1.6

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    curl \
                    vim \
                    sudo \
                    ca-certificates \
                    && \
    apt-get clean

RUN adduser --disabled-login --gecos '' cockroach && \
    usermod -G sudo cockroach

RUN echo "Defaults:cockroach !requiretty" >> /etc/sudoers.d/cockroach && \
    echo "cockroach ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/cockroach && \
    chmod 440 /etc/sudoers.d/cockroach

RUN cd /opt && \
    curl -s https://binaries.cockroachdb.com/cockroach-${cockroachdb_version}.linux-amd64.tgz | tar -xz && \
    mkdir -p /usr/local/lib/cockroach && \
    cp -i cockroach-${cockroachdb_version}.linux-amd64/lib/libgeos.so /usr/local/lib/cockroach && \
    cp -i cockroach-${cockroachdb_version}.linux-amd64/lib/libgeos_c.so /usr/local/lib/cockroach && \
    mv cockroach-${cockroachdb_version}.linux-amd64 cockroach && \
    mkdir -p /var/lib/cockroach/data && \
    chown -R cockroach:cockroach /opt/cockroach* /var/lib/cockroach/data

COPY docker-entrypoint.sh /home/cockroach/docker-entrypoint.sh
RUN chown cockroach:cockroach /home/cockroach/docker-entrypoint.sh && \
    chmod a+x /home/cockroach/docker-entrypoint.sh

USER cockroach
WORKDIR /home/cockroach

EXPOSE 8080 26257

ENTRYPOINT ["/home/cockroach/docker-entrypoint.sh"]
