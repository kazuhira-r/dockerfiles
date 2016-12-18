FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y curl \
                       wget \
                       vim && \
    apt-get install -y haproxy && \
    apt-get install -y rsyslog && \
    apt-get clean

ENTRYPOINT service rsyslog start && service haproxy start && tail -f /dev/null
