FROM ubuntu:22.04

ARG jaeger_version=1.50.0

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                    curl \
                    ca-certificates \
                    vim \
                    sudo \
    && apt-get clean

RUN adduser --disabled-login --gecos '' jaeger \
    && usermod -G sudo jaeger

RUN echo "Defaults:jaeger !requiretty" >> /etc/sudoers.d/jaeger \
    && echo "jaeger ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/jaeger \
    && chmod 440 /etc/sudoers.d/jaeger

WORKDIR /opt
RUN curl -LO -s https://github.com/jaegertracing/jaeger/releases/download/v${jaeger_version}/jaeger-${jaeger_version}-linux-amd64.tar.gz \
    && tar xf jaeger-${jaeger_version}-linux-amd64.tar.gz \
    && mv jaeger-${jaeger_version}-linux-amd64 jaeger \
    && chown -R jaeger:jaeger jaeger


WORKDIR /opt/jaeger

USER jaeger

# Collector
EXPOSE 4317 4318 9411 14250 14268 14269
# Query & UI
EXPOSE 16685 16686 16687 
# all-in-one
EXPOSE 14269

ENTRYPOINT ["./jaeger-all-in-one"]
