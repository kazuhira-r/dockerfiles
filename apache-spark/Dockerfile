FROM java:8

ARG spark_version=1.5.2
ARG hadoop_distribution=hadoop2.6

RUN cd /tmp && \
    wget -q http://d3kbcqa49mib13.cloudfront.net/spark-${spark_version}-bin-${hadoop_distribution}.tgz && \
    tar -C /opt -zxvf spark-${spark_version}-bin-${hadoop_distribution}.tgz && \
    cd /opt && \
    mv spark-${spark_version}-bin-${hadoop_distribution} spark-bin

EXPOSE 7077
