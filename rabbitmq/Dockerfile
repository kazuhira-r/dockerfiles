FROM ubuntu:latest

# see: http://www.rabbitmq.com/debian/pool/main/r/rabbitmq-server/
ENV RABBITMQ_VERSION 3.6.3-1

EXPOSE 5672 25672

RUN apt-get update && \
    apt-get install -y wget \
                       curl \
                       vim \
                       sudo

RUN echo 'deb http://www.rabbitmq.com/debian/ testing main' | \
    tee /etc/apt/sources.list.d/rabbitmq.list && \
    wget -O- https://www.rabbitmq.com/rabbitmq-signing-key-public.asc | \
    apt-key add -

RUN apt-get update && \
    apt-get install -y --allow-unauthenticated rabbitmq-server=${RABBITMQ_VERSION}
    # apt-get install -y rabbitmq-server=${RABBITMQ_VERSION}

ADD add-user.sh add-user.sh
RUN chmod a+x add-user.sh

ENTRYPOINT service rabbitmq-server start && tail -f /dev/null
