FROM ubuntu:latest

ARG ubuntu_version_name=xenial

RUN apt-get update && \
    apt-get install -y curl \
                       wget \
                       vim && \
    ## apt-get install -y software-properties-common && \
    ## add-apt-repository -y ppa:nginx/stable && \
    wget -qO - https://nginx.org/keys/nginx_signing.key | apt-key add - && \
    echo "deb http://nginx.org/packages/mainline/ubuntu/ ${ubuntu_version_name} nginx" >> /etc/apt/sources.list.d/nginx.list && \
    echo "deb-src http://nginx.org/packages/mainline/ubuntu/ ${ubuntu_version_name} nginx" >> /etc/apt/sources.list.d/nginx.list && \
    apt-get update && \
    apt-get install -y nginx && \
    apt-get clean

ENTRYPOINT service nginx start && tail -f /var/log/nginx/access.log /var/log/nginx/error.log
