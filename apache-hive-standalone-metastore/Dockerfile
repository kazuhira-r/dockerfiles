FROM eclipse-temurin:17-jdk-jammy

ARG hive_standalone_metastore_version=3.0.0
ARG hadoop_version=3.3.4

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                    sudo \
                    vim \
                    curl \
                    unzip \
                    ca-certificates \
    && apt-get clean

RUN adduser --disabled-login --gecos '' hive \
    && usermod -G sudo hive

RUN echo "Defaults:hive !requiretty" >> /etc/sudoers.d/hive \
    && echo "hive ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/hive \
    && chmod 440 /etc/sudoers.d/hive

RUN cd /opt \
    && curl -fsSL -O https://dlcdn.apache.org/hive/hive-standalone-metastore-${hive_standalone_metastore_version}/hive-standalone-metastore-${hive_standalone_metastore_version}-bin.tar.gz \
    && tar xf hive-standalone-metastore-${hive_standalone_metastore_version}-bin.tar.gz \
    && mv apache-hive-metastore-${hive_standalone_metastore_version}-bin apache-hive-metastore-bin \
    && chown -R hive:hive apache-hive-metastore-bin

RUN cd /opt \
    && curl -fsSL -O https://dlcdn.apache.org/hadoop/common/hadoop-${hadoop_version}/hadoop-${hadoop_version}.tar.gz \
    && tar xf hadoop-${hadoop_version}.tar.gz \
    && mv hadoop-${hadoop_version} hadoop \
    && chown -R hive:hive hadoop

EXPOSE 9083

WORKDIR /opt/apache-hive-metastore-bin

COPY docker-entrypoint.sh docker-entrypoint.sh
RUN chmod a+x docker-entrypoint.sh && chown hive:hive docker-entrypoint.sh

USER hive

ENTRYPOINT ["./docker-entrypoint.sh"]
