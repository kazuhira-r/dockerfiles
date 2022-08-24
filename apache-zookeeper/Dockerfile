FROM ubuntu:latest

ARG zookeeper_version=3.4.12
ARG zookeeper_home=/opt/apache-zookeeper

ARG zookeeper_data_dir=/var/lib/apache-zookeeper
ARG zookeeper_log_dir=${zookeeper_home}/logs

ARG zookeeper_distribution_url=https://archive.apache.org/dist/zookeeper/zookeeper-${zookeeper_version}/zookeeper-${zookeeper_version}.tar.gz

ENV ZOO_LOG_DIR ${zookeeper_log_dir}

RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y sudo \
                       curl \
                       wget \
                       unzip \
                       vim && \
    apt-get clean

RUN adduser --disabled-login --gecos '' zookeeper && \
    usermod -G sudo zookeeper

RUN echo "Defaults:zookeeper !requiretty" >> /etc/sudoers.d/zookeeper && \
    echo "zookeeper ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/zookeeper && \
    chmod 440 /etc/sudoers.d/zookeeper

RUN cd /opt && \
           wget -q ${zookeeper_distribution_url} && \
           tar -zxf  zookeeper-${zookeeper_version}.tar.gz && \
           mv zookeeper-${zookeeper_version} apache-zookeeper && \
           chown -R zookeeper:zookeeper apache-zookeeper zookeeper-${zookeeper_version}.tar.gz

RUN mkdir -p ${zookeeper_data_dir} ${zookeeper_log_dir} && \
           chown zookeeper:zookeeper ${zookeeper_data_dir} ${zookeeper_log_dir}

WORKDIR ${zookeeper_home}

ADD docker-entrypoint.sh docker-entrypoint.sh
RUN chown -R zookeeper:zookeeper docker-entrypoint.sh && \
           chmod a+x docker-entrypoint.sh

USER zookeeper

EXPOSE 2181

ENTRYPOINT ["/opt/apache-zookeeper/docker-entrypoint.sh"]
