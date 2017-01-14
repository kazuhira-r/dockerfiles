FROM ubuntu:14.04

ARG kibana_major_version=5.1
ARG kibana_repository_major_version=5.x
ARG kibana_version=${kibana_major_version}.2
ARG kibana_repository=https://artifacts.elastic.co/packages/${kibana_repository_major_version}/apt

EXPOSE 5601

RUN apt-get update && \
    apt-get install -y sudo \
                       wget \
                       curl \
                       vim \
                       apt-transport-https && \
    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - && \
    echo "deb ${kibana_repository} stable main" | tee -a /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y kibana=${kibana_version} && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists

RUN cp -p /etc/kibana/kibana.yml /etc/kibana/kibana.yml.default
# RUN chown -R kibana.root /opt/kibana/installedPlugins /opt/kibana/optimize

ADD start_kibana.sh start_kibana.sh
RUN chmod a+x start_kibana.sh

ENTRYPOINT ["./start_kibana.sh"]
