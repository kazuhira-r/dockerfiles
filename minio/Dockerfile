FROM ubuntu:20.04

ARG minio_server_version=20210918180959
ARG minio_client_version=20210902092127

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    sudo \
                    vim \
                    curl \
                    unzip \
                    ca-certificates \
                    && \
    apt-get clean

RUN adduser --disabled-login --gecos '' minio-user && \
    usermod -G sudo minio-user

RUN echo "Defaults:minio-user !requiretty" >> /etc/sudoers.d/minio-user && \
    echo "minio-user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/minio-user && \
    chmod 440 /etc/sudoers.d/minio-user

RUN  mkdir -p /var/lib/minio/data && \
    chown -R minio-user:minio-user /var/lib/minio && \
    curl -s -OL https://dl.min.io/server/minio/release/linux-amd64/minio_${minio_server_version}.0.0_amd64.deb && \
    dpkg -i minio_${minio_server_version}.0.0_amd64.deb && \
    rm minio_${minio_server_version}.0.0_amd64.deb && \
    curl -s -OL "https://dl.min.io/client/mc/release/linux-amd64/mcli_${minio_client_version}.0.0_amd64.deb" && \
    dpkg -i mcli_${minio_client_version}.0.0_amd64.deb && \
    rm mcli_${minio_client_version}.0.0_amd64.deb && \
    curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    sudo ./aws/install && \
    rm -rf awscliv2.zip aws

EXPOSE 9000 9001

USER minio-user

WORKDIR /home/minio-user

ENV MINIO_ROOT_USER=minioadmin
ENV MINIO_ROOT_PASSWORD=minioadmin

RUN { \
    echo "export AWS_ACCESS_KEY_ID=${MINIO_ROOT_USER}"; \
    echo "export AWS_SECRET_ACCESS_KEY=${MINIO_ROOT_PASSWORD}";\
    echo "export AWS_DEFAULT_REGION=us-east-1";\
    echo "# export AWS_DEFAULT_REGION=ap-northeast-1";\
    echo "export MINIO_ENDPOINT=http://localhost:9000";\
    echo "complete -C `which aws_completer` aws"; \
} >> /home/minio-user/.bashrc

ENTRYPOINT ["minio", "server", "/var/lib/minio/data", "--console-address", ":9001"]
