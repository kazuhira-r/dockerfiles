FROM centos:6.6

ARG jdk_version=7u79
ARG jdk_build_no=b15
ARG jdk_rpm=jdk-${jdk_version}-linux-x64.rpm

ENV JAVA_HOME /usr/java/default

## HDFS Ports.
EXPOSE 8020 50010 50020 50070 50075 50090

## YARN Ports.
EXPOSE 8030 8031 8032 8033 8040 8042 8089 10020 10033 13562 19888

## Spark Ports.
EXPOSE 6066 7077 7078 18080 18081

# $ grep EXPOSE Dockerfile | perl -wp -e 's!EXPOSE!!; s!\r?\n!!; s!(\d+) ?!-p $1:$1 !g'

RUN yum install -y wget \
                   sudo \
    && sed -ri 's/Defaults    requiretty/Defaults:root    !requiretty/' /etc/sudoers \
    && wget -q -O /tmp/jdk.rpm --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/${jdk_version}-${jdk_build_no}/${jdk_rpm} \
    && rpm -ivh /tmp/jdk.rpm \
    && wget -q -O /etc/yum.repos.d/cloudera-cdh5.repo http://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/cloudera-cdh5.repo \
    && sed -ri 's/cdh\/5/cdh\/5.4.5/' /etc/yum.repos.d/cloudera-cdh5.repo \
    && yum install -y hadoop \
                   hadoop-hdfs \
                   hadoop-hdfs-namenode \
                   hadoop-hdfs-secondarynamenode \
                   hadoop-hdfs-datanode \
                   hadoop-yarn \
                   hadoop-yarn-resourcemanager \
                   hadoop-yarn-nodemanager \
                   hadoop-mapreduce \
                   hadoop-mapreduce-historyserver \
                   spark-core \
                   spark-master \
                   spark-worker \
                   hive \
                   hadoop-client

RUN cp -Rp /etc/hadoop/conf.empty /etc/hadoop/conf.mine \
    && alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/conf.mine 50 \
    && alternatives --set hadoop-conf /etc/hadoop/conf.mine \
    && mkdir -p /var/lib/hadoop-hdfs/cache/hdfs/name \
    && chown -R hdfs:hdfs /var/lib/hadoop-hdfs/cache/hdfs/name \
    && chmod 775 /var/lib/hadoop-hdfs/cache/hdfs/name \
    && mkdir -p /var/lib/hadoop-hdfs/cache/hdfs/dfs \
    && chown -R hdfs:hdfs /var/lib/hadoop-hdfs/cache/hdfs/dfs \
    && chmod 775 /var/lib/hadoop-hdfs/cache/hdfs/dfs \
    && mkdir -p /var/lib/hadoop-hdfs/cache/hdfs/tmp \
    && chown -R hdfs:hdfs /var/lib/hadoop-hdfs/cache/hdfs/dfs \
    && chmod 775 /var/lib/hadoop-hdfs/cache/hdfs/dfs \
    && cp -Rp /etc/hive/conf.dist /etc/hive/conf.mine \
    && alternatives --install /etc/hive/conf hive-conf /etc/hive/conf.mine 50 \
    && alternatives --set hive-conf /etc/hive/conf.mine \
    && cp -Rp /etc/spark/conf.dist /etc/spark/conf.mine \
    && alternatives --install /etc/spark/conf spark-conf /etc/spark/conf.mine 50 \
    && alternatives --set spark-conf /etc/spark/conf.mine


ADD core-site.xml /etc/hadoop/conf.mine/core-site.xml
ADD hdfs-site.xml /etc/hadoop/conf.mine/hdfs-site.xml
ADD mapred-site.xml /etc/hadoop/conf.mine/mapred-site.xml
ADD yarn-site.xml /etc/hadoop/conf.mine/yarn-site.xml
ADD ./*.sh ./

RUN chmod a+x *.sh

CMD ./init-and-start.sh && tail -f /dev/null
