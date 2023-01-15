FROM ubuntu:22.04

ARG ubuntu_code_name=jammy

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                    curl \
                    vim \
                    ca-certificates \
                    gnupg \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ABF5BD827BD9BF62 \
    ## for stable
    ## && echo "deb http://nginx.org/packages/ubuntu/ ${ubuntu_code_name} nginx" >> /etc/apt/sources.list.d/nginx.list \
    ## && echo "deb-src http://nginx.org/packages/ubuntu/ ${ubuntu_code_name} nginx" >> /etc/apt/sources.list.d/nginx.list \
    ## for mainline
    && echo "deb http://nginx.org/packages/mainline/ubuntu/ ${ubuntu_code_name} nginx" >> /etc/apt/sources.list.d/nginx.list \
    && echo "deb-src http://nginx.org/packages/mainline/ubuntu/ ${ubuntu_code_name} nginx" >> /etc/apt/sources.list.d/nginx.list \
    && apt-get update \
    && apt-get install -y nginx --no-install-recommends \
    && apt-get clean

ENTRYPOINT service nginx start && tail -f /var/log/nginx/access.log /var/log/nginx/error.log
