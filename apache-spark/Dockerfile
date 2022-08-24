FROM adoptopenjdk:11-jdk-hotspot-focal

ARG spark_version=3.1.2
ARG hadoop_distribution=hadoop3.2

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    sudo \
                    unzip \
                    vim \
                    curl \
                    python3 \
                    python3-pip \
                    python3-venv \
                    && \
    apt-get clean

RUN adduser --disabled-login --gecos '' spark && \
    usermod -G sudo spark

RUN echo "Defaults:spark !requiretty" >> /etc/sudoers.d/spark && \
    echo "spark ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/spark && \
    chmod 440 /etc/sudoers.d/spark

RUN cd /opt && \
    curl -OLs https://downloads.apache.org/spark/spark-${spark_version}/spark-${spark_version}-bin-${hadoop_distribution}.tgz && \
    tar -xf spark-${spark_version}-bin-${hadoop_distribution}.tgz && \
    mv spark-${spark_version}-bin-${hadoop_distribution} spark

COPY docker-entrypoint.sh /opt/spark/docker-entrypoint.sh
RUN chmod a+x /opt/spark/docker-entrypoint.sh && chown spark:spark /opt/spark/docker-entrypoint.sh

WORKDIR /opt/spark

EXPOSE 7077 8080

USER spark

ENTRYPOINT ["/opt/spark/docker-entrypoint.sh"]
CMD ["master"]
