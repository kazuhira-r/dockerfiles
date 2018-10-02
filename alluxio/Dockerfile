FROM ubuntu:latest

ARG alluxio_version=1.7.1
ARG alluxio_home=/opt/alluxio

RUN apt-get update && \
           apt-get install -y openjdk-8-jdk && \
           apt-get install -y sudo \
                                              curl \
                                              wget \
                                              unzip \
                                              vim && \
           apt-get clean

RUN adduser --disabled-login --gecos '' alluxio && \
    usermod -G sudo alluxio

RUN echo "Defaults:alluxio !requiretty" >> /etc/sudoers.d/alluxio && \
    echo "alluxio ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/alluxio && \
    chmod 440 /etc/sudoers.d/alluxio

WORKDIR /opt

RUN cd /opt && \
           wget -q http://downloads.alluxio.org/downloads/files/${alluxio_version}/alluxio-${alluxio_version}-bin.tar.gz && \
           tar -xf alluxio-${alluxio_version}-bin.tar.gz && \
           find alluxio-${alluxio_version}* -maxdepth 0 -type d | xargs -I {} mv {} alluxio && \
           chown -R alluxio.alluxio alluxio

WORKDIR ${alluxio_home}

ADD docker-entrypoint.sh docker-entrypoint.sh
RUN chown  alluxio.alluxio docker-entrypoint.sh && \
           chmod a+x docker-entrypoint.sh

USER alluxio
EXPOSE 19998 19999 29998 29999  30000 39999

ENTRYPOINT ["/opt/alluxio/docker-entrypoint.sh"]
