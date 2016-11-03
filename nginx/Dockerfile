FROM ubuntu:latest

ENV UBUNTU_VERSION_NAME xenial

RUN apt-get update && \
    apt-get install -y curl \
                       wget \
                       vim && \
    ## apt-get install -y software-properties-common && \
    ## add-apt-repository -y ppa:nginx/stable && \
    echo "deb http://nginx.org/packages/ubuntu/ ${UBUNTU_VERSION_NAME} nginx" >> /etc/apt/sources.list.d/nginx.list && \
    echo "deb-src http://nginx.org/packages/ubuntu/ ${UBUNTU_VERSION_NAME} nginx" >> /etc/apt/sources.list.d/nginx.list && \
    apt-get update && \
    apt-get install -y --allow-unauthenticated nginx

ENTRYPOINT service nginx start && tail -f /var/log/nginx/access.log /var/log/nginx/error.log
