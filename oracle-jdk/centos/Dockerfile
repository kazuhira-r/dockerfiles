FROM centos:7

ENV JDK_VERSION 8u60
ENV JDK_BUILD_NO b27
ENV JDK_RPM jdk-${JDK_VERSION}-linux-x64.rpm

ENV JAVA_HOME /usr/java/default

RUN yum install -y wget && \
    wget -q \
         --no-check-certificate \
         --no-cookies \
         --header "Cookie: oraclelicense=accept-securebackup-cookie" \
         http://download.oracle.com/otn-pub/java/jdk/${JDK_VERSION}-${JDK_BUILD_NO}/${JDK_RPM} && \
    rpm -ivh ${JDK_RPM}

CMD "/bin/bash"
