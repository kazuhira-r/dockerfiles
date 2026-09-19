FROM ubuntu:24.04

ARG otel_tui_version=0.7.5

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

RUN curl -fsSL -O https://github.com/ymtdzzz/otel-tui/releases/download/v${otel_tui_version}/otel-tui_Linux_x86_64.tar.gz \
    && tar xf otel-tui_Linux_x86_64.tar.gz -C /usr/local/bin otel-tui \
    && rm otel-tui_Linux_x86_64.tar.gz

USER user

EXPOSE 4317 4318

ENTRYPOINT ["otel-tui"]
CMD []
