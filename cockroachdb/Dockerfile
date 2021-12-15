FROM ubuntu:20.04

ARG cockroachdb_version=v21.2.3

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    curl \
                    vim \
                    sudo \
                    ca-certificates \
                    jq \
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

COPY set-certs-dir /home/cockroach/set-certs-dir
COPY login-cluster /home/cockroach/login-cluster
COPY init-cluster.sh /home/cockroach/init-cluster.sh
RUN chown cockroach:cockroach /home/cockroach/init-cluster.sh && \
    chmod a+x /home/cockroach/init-cluster.sh
COPY call-api.sh /home/cockroach/call-api.sh
RUN chown cockroach:cockroach /home/cockroach/call-api.sh && \
    chmod a+x /home/cockroach/call-api.sh
COPY create-user.sh /home/cockroach/create-user.sh
RUN chown cockroach:cockroach /home/cockroach/create-user.sh && \
    chmod a+x /home/cockroach/create-user.sh
COPY procedure.txt /home/cockroach/procedure.txt

USER cockroach
WORKDIR /home/cockroach

ENV PATH=/opt/cockroach:${PATH}

EXPOSE 8080 26257

ENTRYPOINT ["/home/cockroach/docker-entrypoint.sh"]
