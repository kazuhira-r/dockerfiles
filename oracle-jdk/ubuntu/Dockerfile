FROM ubuntu:latest

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN echo oracle-java-8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    apt update && \
    apt install -y software-properties-common && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt update && \
    apt install -y oracle-java8-installer && \
    apt install -y sudo \
                   wget \
                   curl \
                   unzip \
                   vim && \
    apt clean
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists && \
#    rm -rf /var/cache/oracle-jdk*-installer

RUN adduser --disabled-login --gecos '' jdk-user && \
    usermod -G sudo jdk-user

RUN echo "Defaults:jdk-user !requiretty" >> /etc/sudoers.d/jdk-user && \
    echo "jdk-user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/jdk-user && \
    chmod 440 /etc/sudoers.d/jdk-user

USER jdk-user

CMD "/bin/bash"
