FROM ubuntu:20.04

ARG consul_version=1.9.3
ARG consul_template_version=0.25.1

ARG consul_home=/opt/consul
ARG consul_lib_dir=/var/lib/consul
ARG consul_data_dir=${consul_lib_dir}/data
ARG consul_log_dir=/var/log/consul
ARG consul_config_dir=/etc/consul.d

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    sudo \
                    unzip \
                    vim \
                    curl \
                    ca-certificates \
                    rsyslog \
                    less \
                    && \
    apt-get clean && \
    mkdir -p ${consul_home} ${consul_data_dir} ${consul_log_dir} ${consul_config_dir} && \
    touch ${consul_log_dir}/consul.log && \
    cd ${consul_home} && \
    curl -s -LO https://releases.hashicorp.com/consul/${consul_version}/consul_${consul_version}_linux_amd64.zip && \
    curl -s -LO https://releases.hashicorp.com/consul-template/${consul_template_version}/consul-template_${consul_template_version}_linux_amd64.zip && \
    unzip consul_${consul_version}_linux_amd64.zip && \
    unzip consul-template_${consul_template_version}_linux_amd64.zip

RUN echo "local0.*			${consul_log_dir}/consul.log" >> /etc/rsyslog.d/consul.conf && \
    perl -wpi -e 's!^(\*\.\*\S+)(.+)!$1,local0.none$2!' /etc/rsyslog.d/50-default.conf


RUN adduser --disabled-login --gecos '' consul && \
    usermod -G sudo consul

RUN echo "Defaults:consul !requiretty" >> /etc/sudoers.d/consul && \
    echo "consul ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/consul && \
    chmod 440 /etc/sudoers.d/consul

RUN chown -R consul.consul ${consul_home} ${consul_lib_dir} ${consul_config_dir} && \
    chown -R syslog.syslog ${consul_log_dir} && \
    chmod 755 ${consul_log_dir}


USER consul
WORKDIR ${consul_home}

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN sudo chmod a+x /docker-entrypoint.sh && sudo chown consul.consul /docker-entrypoint.sh

#ENTRYPOINT service rsyslog start && tail -f ${consul_log_dir}/consul.log
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["-server", "-ui", "-client", "0.0.0.0", "-bootstrap", "-data-dir", "/var/lib/consul/data"]
