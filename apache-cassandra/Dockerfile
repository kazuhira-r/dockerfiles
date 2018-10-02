FROM ubuntu:latest

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

ARG cassandra_version=3.11.2
ARG cassandra_repository_version=311x

RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y sudo \
                       curl \
                       wget \
                       gnupg \
                       tzdata \
                       vim && \
    echo "deb http://www.apache.org/dist/cassandra/debian ${cassandra_repository_version} main" | tee -a /etc/apt/sources.list.d/cassandra.sources.list && \
    curl https://www.apache.org/dist/cassandra/KEYS | sudo apt-key add - && \
    apt-get update && \
    apt-get install -y cassandra=${cassandra_version} && \
    sudo -u cassandra touch /var/log/cassandra/system.log && \
    apt-get clean

RUN adduser --disabled-login --gecos '' cassandra-user && \
    usermod -G sudo cassandra-user

RUN echo "Defaults:cassandra-user !requiretty" >> /etc/sudoers.d/cassandra-user && \
    echo "cassandra-user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/cassandra-user && \
    chmod 440 /etc/sudoers.d/cassandra-user

# 7000: intra-node communication
# 7001: TLS intra-node communication
# 7199: JMX
# 9042: CQL
# 9160: thrift service
EXPOSE 7000 7001 7199 9042 9160

WORKDIR /home/cassandra-user
USER cassandra-user

ADD start-cassandra.sh start-cassandra.sh
RUN sudo chown cassandra-user.cassandra-user start-cassandra.sh && \
    chmod a+x start-cassandra.sh
ENTRYPOINT ["./start-cassandra.sh"]
