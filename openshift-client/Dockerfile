FROM ubuntu:latest

ARG openshift_client_base_url=https://github.com/openshift/origin/releases/download
ARG openshift_client_version=v3.10.0
ARG openshift_client_distribution=openshift-origin-client-tools-${openshift_client_version}-dd10d17-linux-64bit
ARG openshift_client_distribution_filename=${openshift_client_distribution}.tar.gz

RUN apt-get update -y && \
           apt-get install -y sudo \
                                              vim \
                                              wget \
                                              git \
                                              bash-completion \
                                              && \
           apt-get clean

RUN adduser --disabled-login --gecos '' openshift-user && \
    usermod -G sudo openshift-user

RUN echo "Defaults:openshift-user !requiretty" >> /etc/sudoers.d/openshift-user && \
    echo "openshift-user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/openshift-user && \
    chmod 440 /etc/sudoers.d/openshift-user


RUN cd /opt && \
           wget -q ${openshift_client_base_url}/${openshift_client_version}/${openshift_client_distribution_filename} && \
           tar xf ${openshift_client_distribution_filename} && \
           mv ${openshift_client_distribution} openshift-client && \
           chown -R openshift-user.openshift-user openshift-client && \
           rm ${openshift_client_distribution_filename}

USER openshift-user

ENV PATH /opt/openshift-client:${PATH}

CMD echo "###### setup bash completion ######\n \$ source <(oc completion bash)\n\n###################################\n" && bash
