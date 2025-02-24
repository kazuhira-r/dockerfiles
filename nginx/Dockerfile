FROM ubuntu:24.04

ARG ubuntu_code_name=noble

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                    sudo \
                    adduser \
                    passwd \
                    curl \
                    vim \
                    ca-certificates \
                    gnupg2 \
                    lsb-release \
                    ubuntu-keyring \
    && curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null \
    ## for stable
    ##&& echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/ubuntu $(lsb_release -cs) nginx"  | sudo tee /etc/apt/sources.list.d/nginx.list \
    ## for mainline
    && echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/mainline/ubuntu $(lsb_release -cs) nginx"  | sudo tee /etc/apt/sources.list.d/nginx.list \
    #&& echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n"  | sudo tee /etc/apt/preferences.d/99nginx \
    && apt-get update \
    && apt-get install -y nginx --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT service nginx start && tail -f /var/log/nginx/access.log /var/log/nginx/error.log
