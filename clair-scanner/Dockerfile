FROM golang:1.11 AS build

RUN mkdir -p /go/src/github.com/arminc \
    && cd /go/src/github.com/arminc \
    && git clone https://github.com/arminc/clair-scanner.git \
    && cd clair-scanner \
    && make \
    && make ensure \
    && make build

FROM ubuntu:latest

COPY --from=build /go/src/github.com/arminc/clair-scanner/clair-scanner /usr/local/bin

RUN apt-get update \
    && apt-get install -y sudo \
                       vim \
                       git \
                       curl \
                       wget \
    && apt-get clean

RUN adduser --disabled-login --gecos '' clair \
    && usermod -G sudo clair

RUN echo "Defaults:clair !requiretty" >> /etc/sudoers.d/clair \
    && echo "clair ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/clair \
    && chmod 440 /etc/sudoers.d/clair

USER clair

CMD ["bash"]
