FROM ubuntu:22.04

ARG qdrant_version=1.7.4
ARG qdrant_web_ui_version=0.1.21
# https://github.com/qdrant/qdrant-web-ui/releases

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                    curl \
                    ca-certificates \
                    unzip \
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

RUN mkdir static \
    && curl -LO -s https://github.com/qdrant/qdrant-web-ui/releases/download/v${qdrant_web_ui_version}/dist-qdrant.zip \
    && unzip dist-qdrant.zip -d static \
    && mv static/dist/* static \
    && rmdir static/dist \
    && chown -R qdrant:qdrant /opt/qdrant

USER qdrant

EXPOSE 6333 6334

ENTRYPOINT ["./qdrant"]
