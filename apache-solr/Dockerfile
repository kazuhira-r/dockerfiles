FROM ubuntu:latest

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

ARG solr_version=5.4.1
ARG solr_archive=solr-${solr_version}.tgz

ARG solr_install_dir=/opt
ARG solr_data_dir=/var/solr
ARG solr_port=8983

ARG solr_core_name=mycore

## Oracle JDK 8インストール
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
    && apt-get update \
    && apt-get install -y software-properties-common \
    && add-apt-repository -y ppa:webupd8team/java \
    && apt-get update \
    && apt-get install -y oracle-java8-installer

## ツールインストール
RUN apt-get install -y sudo \
                       lsof \
                       curl \
                       vim

## 日本語環境サポート
RUN apt-get install -y language-pack-ja-base \
                       language-pack-ja \
                       ibus-mozc \
                       man \
                       manpages-ja \
    && update-locale LANG=ja_JP.UTF-8 LANGUAGE=ja_JP:ja

ENV LANG ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8

## Solrインストール
RUN wget -q http://archive.apache.org/dist/lucene/solr/${solr_version}/${solr_archive} \
    && tar -zxvf ${solr_archive} solr-${solr_version}/bin/install_solr_service.sh \
    && solr-${solr_version}/bin/install_solr_service.sh ${solr_archive} -i ${solr_install_dir} -d ${solr_data_dir} -p ${solr_port}

EXPOSE ${solr_port}

## コア作成
RUN service solr restart \
    && sudo -u solr ${solr_install_dir}/solr/bin/solr create -c ${solr_core_name} \
    && service solr stop \
    && rm /var/solr/data/${solr_core_name}/conf/managed-schema

ADD solrconfig.xml /var/solr/data/${solr_core_name}/conf/solrconfig.xml
ADD schema.xml /var/solr/data/${solr_core_name}/conf/schema.xml

## 実行コマンド
ENTRYPOINT service solr start && tail -f /dev/null
