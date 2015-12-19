FROM java:8

ENV SPARK_VERSION 1.4.1
ENV HADOOP_DISTRIBUTION hadoop2.6

RUN cd /tmp && \
    wget -q http://d3kbcqa49mib13.cloudfront.net/spark-${SPARK_VERSION}-bin-${HADOOP_DISTRIBUTION}.tgz && \
    tar -C /opt -zxvf spark-${SPARK_VERSION}-bin-${HADOOP_DISTRIBUTION}.tgz && \
    cd /opt && \
    mv spark-${SPARK_VERSION}-bin-${HADOOP_DISTRIBUTION} spark-bin

EXPOSE 7077
