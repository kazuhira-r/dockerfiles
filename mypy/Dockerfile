FROM python:3.12-slim-trixie

ARG mypy_version=1.18.2

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

RUN adduser --disabled-login --gecos '' user \
    && usermod -G sudo user

RUN echo "Defaults:user !requiretty" >> /etc/sudoers.d/user \
    && echo "user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/user \
    && chmod 440 /etc/sudoers.d/user

USER user

RUN pip install --no-cache-dir mypy==${mypy_version}

RUN { \
    echo '[mypy]'; \
    echo 'strict = True'; \
    echo 'disallow_any_unimported = True'; \
    echo 'disallow_any_expr = True'; \
    echo 'disallow_any_explicit = True'; \
    echo 'warn_unreachable = True'; \
    echo 'pretty = True'; \
} > /home/user/.mypy.ini

ENTRYPOINT ["/home/user/.local/bin/mypy"]
CMD []
