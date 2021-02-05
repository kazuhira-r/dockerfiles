FROM ubuntu:20.04

ARG ubuntu_code_name=focal

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    curl \
                    vim \
                    ca-certificates \
                    gnupg \
                    && \
    ## apt-get install -y software-properties-common && \
    ## add-apt-repository -y ppa:nginx/stable && \
    curl -sL https://nginx.org/keys/nginx_signing.key -o - | apt-key add - && \
    echo "deb http://nginx.org/packages/mainline/ubuntu/ ${ubuntu_code_name} nginx" >> /etc/apt/sources.list.d/nginx.list && \
    echo "deb-src http://nginx.org/packages/mainline/ubuntu/ ${ubuntu_code_name} nginx" >> /etc/apt/sources.list.d/nginx.list && \
    apt-get update && \
    apt-get install -y nginx && \
    apt-get clean

ENTRYPOINT service nginx start && tail -f /var/log/nginx/access.log /var/log/nginx/error.log
