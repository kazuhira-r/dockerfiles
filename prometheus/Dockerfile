FROM ubuntu:latest

RUN apt-get update -y && \
           apt-get install -y sudo \
                                              curl \
                                              wget \
                                              gnupg \
                                              vim && \
           apt-get clean

RUN adduser --disabled-login --gecos '' prometheus-user && \
    usermod -G sudo prometheus-user

RUN echo "Defaults:prometheus-user !requiretty" >> /etc/sudoers.d/prometheus-user && \
    echo "prometheus-user ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/prometheus-user && \
    chmod 440 /etc/sudoers.d/prometheus-user

RUN curl -fsSL https://s3-eu-west-1.amazonaws.com/deb.robustperception.io/41EFC99D.gpg | apt-key add - && \
           apt-get update -y && \
           apt-get install -y prometheus \
                                              prometheus-node-exporter \
                                              prometheus-pushgateway \
                                              prometheus-alertmanager

EXPOSE 9090

USER prometheus-user

ENTRYPOINT sudo service prometheus start && sudo -u prometheus touch /var/log/prometheus/prometheus.log && tail -f /var/log/prometheus/prometheus.log
