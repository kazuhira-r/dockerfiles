FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                    sudo \
                    adduser \
                    passwd \
                    vim \
                    ca-certificates \
                    sudo \
                    apache2 \
                    ssl-cert \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && a2enmod ssl \
    && a2ensite default-ssl

RUN adduser --disabled-login --gecos '' user \
    && usermod -G sudo user

RUN echo "Defaults:user !requiretty" >> /etc/sudoers.d/user \
    && echo "user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/user \
    && chmod 440 /etc/sudoers.d/user

RUN ln -sf /dev/stdout /var/log/apache2/access.log \
    && ln -sf /dev/stderr  /var/log/apache2/error.log

EXPOSE 80 443

USER user

ENTRYPOINT ["sudo", "/usr/sbin/apachectl", "-DFOREGROUND"]
