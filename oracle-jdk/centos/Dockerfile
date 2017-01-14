FROM centos:7

ARG jdk_version=8u77
ARG jdk_build_no=b03
ARG jdk_rpm=jdk-${jdk_version}-linux-x64.rpm

ENV JAVA_HOME /usr/java/default

RUN yum install -y wget && \
    wget -q \
         --no-check-certificate \
         --no-cookies \
         --header "Cookie: oraclelicense=accept-securebackup-cookie" \
         http://download.oracle.com/otn-pub/java/jdk/${jdk_version}-${jdk_build_no}/${jdk_rpm} && \
    rpm -ivh ${jdk_rpm}

CMD "/bin/bash"
