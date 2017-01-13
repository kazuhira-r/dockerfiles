FROM ubuntu:latest

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y oracle-java8-installer && \
    apt-get install -y sudo \
                       curl \
                       wget \
                       vim && \
    echo "deb http://www.apache.org/dist/cassandra/debian 39x main" | tee -a /etc/apt/sources.list.d/cassandra.sources.list && \
    curl https://www.apache.org/dist/cassandra/KEYS | sudo apt-key add - && \
    apt-get update && \
    apt-get install -y cassandra && \
    sudo -u cassandra touch /var/log/cassandra/system.log && \
    apt-get clean

# 7000: intra-node communication
# 7001: TLS intra-node communication
# 7199: JMX
# 9042: CQL
# 9160: thrift service
EXPOSE 7000 7001 7199 9042 9160

ENTRYPOINT service cassandra start && tail -f /var/log/cassandra/system.log
