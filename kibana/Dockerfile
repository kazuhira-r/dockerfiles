FROM ubuntu:latest

ENV KIBANA_MAJAR_VERSION 5.0
ENV KIBANA_REPOSITORY_MAJAR_VERSION 5.x
ENV KIBANA_VERSION ${KIBANA_MAJAR_VERSION}.1
ENV KIBANA_REPOSITORY https://artifacts.elastic.co/packages/${KIBANA_REPOSITORY_MAJAR_VERSION}/apt

EXPOSE 5601

RUN apt-get update && \
    apt-get install -y sudo \
                       wget \
                       curl \
                       vim \
                       apt-transport-https && \
    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - && \
    echo "deb ${KIBANA_REPOSITORY} stable main" | tee -a /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y kibana=${KIBANA_VERSION} && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists

RUN cp -p /etc/kibana/kibana.yml /etc/kibana/kibana.yml.default
# RUN chown -R kibana.root /opt/kibana/installedPlugins /opt/kibana/optimize

ADD start_kibana.sh start_kibana.sh
RUN chmod a+x start_kibana.sh

ENTRYPOINT ["./start_kibana.sh"]
