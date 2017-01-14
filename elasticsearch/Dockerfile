FROM ubuntu:14.04

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

ARG elasticsearch_version=5.1.2
ARG elasticsearch_repository_version=5.x
ARG elasticsearch_repository=https://artifacts.elastic.co/packages/${elasticsearch_repository_version}/apt

EXPOSE 9200 9300

## Oracle JDK 8インストール
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y oracle-java8-installer && \
## ツールインストール
    apt-get install -y sudo \
                       wget \
                       curl \
                       vim \
                       apt-transport-https && \
## Elasticsearchインストール
    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - && \
    echo "deb ${elasticsearch_repository} stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-${elasticsearch_repository_version}.list && \
    apt-get update && \
    apt-get install -y elasticsearch=${elasticsearch_version} && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists && \
    rm -rf /var/cache/oracle-jdk*-installer

RUN cp -p /etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml.default
ADD elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
RUN chown root.elasticsearch /etc/elasticsearch/elasticsearch.yml

## Elasticsearchプラグインインストール
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install analysis-kuromoji

## プラグイン等向け設定ファイル
RUN touch /etc/elasticsearch/userdict_ja.txt && \
    chown root.elasticsearch /etc/elasticsearch/userdict_ja.txt

ENTRYPOINT service elasticsearch start && \
            sudo -u elasticsearch touch /var/log/elasticsearch/elasticsearch.log && \
            tailf /var/log/elasticsearch/elasticsearch.log
