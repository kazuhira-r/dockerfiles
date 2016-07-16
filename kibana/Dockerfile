FROM ubuntu:latest

ENV KIBANA_MAJAR_VERSION 4.5
ENV KIBANA_VERSION ${KIBANA_MAJAR_VERSION}.3
ENV KIBANA_REPOSITORY http://packages.elastic.co/kibana/${KIBANA_MAJAR_VERSION}/debian

EXPOSE 5601

RUN apt-get update && \
    apt-get install -y sudo \
                       wget \
                       curl \
                       vim

RUN wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add - && \
    echo "deb ${KIBANA_REPOSITORY} stable main" | tee -a /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y kibana=${KIBANA_VERSION}

RUN chown -R kibana.root /opt/kibana/installedPlugins /opt/kibana/optimize && \
    sudo -u kibana /opt/kibana/bin/kibana plugin --install elastic/sense

ADD start_kibana.sh start_kibana.sh
RUN chmod a+x start_kibana.sh

ENTRYPOINT ["./start_kibana.sh"]
