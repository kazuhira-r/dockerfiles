FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y curl \
                       wget \
                       vim && \
    apt-get install -y haproxy && \
    apt-get clean

ENTRYPOINT service haproxy start && tail -f /dev/null
