FROM ubuntu:22.04

ARG qdrant_version=1.7.3

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                    curl \
                    ca-certificates \
                    vim \
                    sudo \
    && apt-get clean

RUN adduser --disabled-login --gecos '' qdrant \
    && usermod -G sudo qdrant

RUN echo "Defaults:qdrant !requiretty" >> /etc/sudoers.d/qdrant \
    && echo "qdrant ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/qdrant \
    && chmod 440 /etc/sudoers.d/qdrant

RUN mkdir /opt/qdrant

WORKDIR /opt/qdrant

RUN curl -LO -s https://github.com/qdrant/qdrant/releases/download/v${qdrant_version}/qdrant-x86_64-unknown-linux-gnu.tar.gz \
    && tar xf qdrant-x86_64-unknown-linux-gnu.tar.gz \
    && chown -R qdrant:qdrant /opt/qdrant

USER qdrant

EXPOSE 6333 6334

ENTRYPOINT ["./qdrant"]
