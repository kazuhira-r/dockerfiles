FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y curl \
                       wget \
                       vim && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:nginx/stable && \
    #deb http://nginx.org/packages/ubuntu/ xenial nginx && \
    #deb-src http://nginx.org/packages/ubuntu/ xenial nginx && \
    apt-get update && \
    apt-get install -y nginx

ENTRYPOINT service nginx start && tail -f /var/log/nginx/access.log /var/log/nginx/error.log
