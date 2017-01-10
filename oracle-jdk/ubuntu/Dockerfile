FROM ubuntu:latest

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y oracle-java8-installer && \
    apt-get install -y sudo \
                       wget \
                       curl \
                       vim && \
    apt-get clean
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists && \
#    rm -rf /var/cache/oracle-jdk*-installer

RUN adduser --disabled-password --gecos '' jdk-user && \
    echo jdk-user:password | chpasswd && \
    usermod -G sudo jdk-user

USER jdk-user

CMD "/bin/bash"
