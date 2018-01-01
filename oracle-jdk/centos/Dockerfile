FROM centos:7

ARG jdk_version=9.0.1
ARG jdk_build_no=11
ARG jdk_rpm=jdk-${jdk_version}_linux-x64_bin.rpm
#ARG jdk_rpm=jdk-${jdk_version}-linux-x64.rpm

ENV JAVA_HOME /usr/java/default

RUN yum install -y wget && \
    wget -q \
         --no-check-certificate \
         --no-cookies \
         --header "Cookie: oraclelicense=accept-securebackup-cookie" \
         http://download.oracle.com/otn-pub/java/jdk/${jdk_version}+${jdk_build_no}/${jdk_rpm} && \
         # http://download.oracle.com/otn-pub/java/jdk/${jdk_version}-${jdk_build_no}/${jdk_rpm} && \
    rpm -ivh ${jdk_rpm}

CMD "/bin/bash"
