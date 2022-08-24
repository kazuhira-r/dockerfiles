FROM centos:6.6

ARG jdk_version=7u79
ARG jdk_build_no=b15
ARG jdk_rpm=jdk-${jdk_version}-linux-x64.rpm

ENV JAVA_HOME /usr/java/default

EXPOSE 8020 8030 8031 8032 8033 8040 8042 8089 10020 10033 13562 19888 40906 50010 50020 50070 50075
# -p 8020:8020 -p 8030:8030 -p 8031:8031 -p 8032:8032 -p 8033:8033 -p 8040:8040 -p 8042:8042 -p 8089:8089 -p 10020:10020 -p 10033:10033 -p 13562:13562 -p 19888:19888 -p 40906:40906 -p 50010:50010 -p 50020:50020 -p 50070:50070 -p 50075:50075

RUN yum install -y wget \
                   sudo && \
    sed -ri 's/Defaults    requiretty/Defaults:root    !requiretty/' /etc/sudoers && \
    wget -q -O /tmp/jdk.rpm --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/${jdk_version}-${jdk_build_no}/${jdk_rpm} && \
    rpm -ivh /tmp/jdk.rpm && \
    wget -q -O /etc/yum.repos.d/cloudera-cdh5.repo http://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/cloudera-cdh5.repo && \
    sed -ri 's/cdh\/5/cdh\/5.4.4/' /etc/yum.repos.d/cloudera-cdh5.repo && \
    yum install -y hadoop \
                   hadoop-hdfs \
                   hadoop-hdfs-namenode \
                   hadoop-hdfs-secondarynamenode \
                   hadoop-hdfs-datanode \
                   hadoop-yarn \
                   hadoop-yarn-resourcemanager \
                   hadoop-yarn-nodemanager \
                   hadoop-mapreduce \
                   hadoop-mapreduce-historyserver \
                   hadoop-client

RUN cp -Rp /etc/hadoop/conf.empty /etc/hadoop/conf.mine && \
    alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/conf.mine 50 && \
    alternatives --set hadoop-conf /etc/hadoop/conf.mine && \
    mkdir -p /var/lib/hadoop-hdfs/cache/hdfs/name && \
    chown -R hdfs:hdfs /var/lib/hadoop-hdfs/cache/hdfs/name && \
    chmod 775 /var/lib/hadoop-hdfs/cache/hdfs/name && \
    mkdir -p /var/lib/hadoop-hdfs/cache/hdfs/dfs && \
    chown -R hdfs:hdfs /var/lib/hadoop-hdfs/cache/hdfs/dfs && \
    chmod 775 /var/lib/hadoop-hdfs/cache/hdfs/dfs && \
    mkdir -p /var/lib/hadoop-hdfs/cache/hdfs/tmp && \
    chown -R hdfs:hdfs /var/lib/hadoop-hdfs/cache/hdfs/dfs && \
    chmod 775 /var/lib/hadoop-hdfs/cache/hdfs/dfs

ADD core-site.xml /etc/hadoop/conf.mine/core-site.xml
ADD hdfs-site.xml /etc/hadoop/conf.mine/hdfs-site.xml
ADD mapred-site.xml /etc/hadoop/conf.mine/mapred-site.xml
ADD yarn-site.xml /etc/hadoop/conf.mine/yarn-site.xml
ADD fix-hostname.sh fix-hostname.sh
ADD init-and-start.sh init-and-start.sh

RUN chmod a+x fix-hostname.sh
RUN chmod a+x init-and-start.sh

CMD ./init-and-start.sh && tail -f /dev/null
