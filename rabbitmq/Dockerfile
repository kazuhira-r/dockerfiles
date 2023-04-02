FROM ubuntu:22.04

# see: https://packagecloud.io/rabbitmq/rabbitmq-server/
ARG rabbitmq_version=3.11.12-1

EXPOSE 5672 25672

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                    curl \
                    ca-certificates \
                    vim \
                    sudo \
                    gnupg \
    &&  apt-get clean

RUN adduser --disabled-login --gecos '' user \
    && usermod -G sudo user

RUN echo "Defaults:user !requiretty" >> /etc/sudoers.d/user \
    && echo "user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/user \
    && chmod 440 /etc/sudoers.d/user

RUN apt-get install -y --no-install-recommends apt-transport-https \
    && curl -1sLf "https://keys.openpgp.org/vks/v1/by-fingerprint/0A9AF2115F4687BD29803A206B73A36E6026DFCA" | gpg --dearmor | tee /usr/share/keyrings/com.rabbitmq.team.gpg > /dev/null \
    && curl -1sLf "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xf77f1eda57ebb1cc" | gpg --dearmor | tee /usr/share/keyrings/net.launchpad.ppa.rabbitmq.erlang.gpg > /dev/null \
    && curl -1sLf "https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey" | gpg --dearmor | tee /usr/share/keyrings/io.packagecloud.rabbitmq.gpg > /dev/null \
    && { \
        echo 'deb [signed-by=/usr/share/keyrings/net.launchpad.ppa.rabbitmq.erlang.gpg] http://ppa.launchpad.net/rabbitmq/rabbitmq-erlang/ubuntu jammy main'; \
        echo 'deb-src [signed-by=/usr/share/keyrings/net.launchpad.ppa.rabbitmq.erlang.gpg] http://ppa.launchpad.net/rabbitmq/rabbitmq-erlang/ubuntu jammy main'; \
        echo 'deb [signed-by=/usr/share/keyrings/io.packagecloud.rabbitmq.gpg] https://packagecloud.io/rabbitmq/rabbitmq-server/ubuntu/ jammy main'; \
        echo 'deb-src [signed-by=/usr/share/keyrings/io.packagecloud.rabbitmq.gpg] https://packagecloud.io/rabbitmq/rabbitmq-server/ubuntu/ jammy main'; \
    } > /etc/apt/sources.list.d/rabbitmq.list

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                    erlang-base \
                    erlang-asn1 erlang-crypto erlang-eldap erlang-ftp erlang-inets \
                    erlang-mnesia erlang-os-mon erlang-parsetools erlang-public-key \
                    erlang-runtime-tools erlang-snmp erlang-ssl \
                    erlang-syntax-tools erlang-tftp erlang-tools erlang-xmerl \
    && apt-get install -y --no-install-recommends \
                    rabbitmq-server=${rabbitmq_version} --fix-missing \
    && apt-get clean

RUN rabbitmq-plugins enable rabbitmq_management

COPY add-user.sh /home/user/add-user.sh
RUN chown user:user /home/user/add-user.sh \
    && chmod a+x /home/user/add-user.sh

USER user
WORKDIR /home/user

ENTRYPOINT sudo service rabbitmq-server start && sudo -u rabbitmq touch /var/log/rabbitmq/rabbit@$(hostname).log && sudo tail -f /var/log/rabbitmq/rabbit@$(hostname).log
