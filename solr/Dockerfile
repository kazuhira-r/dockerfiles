FROM ubuntu:latest

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

ENV SOLR_VERSION 5.4.0
ENV SOLR_ARCHIVE solr-${SOLR_VERSION}.tgz

ENV SOLR_INSTALL_DIR /opt
ENV SOLR_DATA_DIR /var/solr
ENV SOLR_PORT 8983

ENV SOLR_CORE_NAME mycore

## Oracle JDK 8インストール
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y oracle-java8-installer

## ツールインストール
RUN apt-get install -y lsof \
                       curl \
                       vim

## 日本語環境サポート
RUN apt-get install -y language-pack-ja-base \
                       language-pack-ja \
                       ibus-mozc \
                       man \
                       manpages-ja && \
    update-locale LANG=ja_JP.UTF-8 LANGUAGE=ja_JP:ja

ENV LANG ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8

## Solrインストール
RUN wget -q http://ftp.jaist.ac.jp/pub/apache//lucene/solr/${SOLR_VERSION}/${SOLR_ARCHIVE} && \
    tar -zxvf ${SOLR_ARCHIVE} solr-${SOLR_VERSION}/bin/install_solr_service.sh && \
    solr-${SOLR_VERSION}/bin/install_solr_service.sh ${SOLR_ARCHIVE} -i ${SOLR_INSTALL_DIR} -d ${SOLR_DATA_DIR} -p ${SOLR_PORT}

EXPOSE ${SOLR_PORT}

## コア作成
RUN service solr restart && \
    sudo -u solr ${SOLR_INSTALL_DIR}/solr/bin/solr create -c ${SOLR_CORE_NAME} && \
    service solr stop && \
    rm /var/solr/data/${SOLR_CORE_NAME}/conf/managed-schema

ADD solrconfig.xml /var/solr/data/${SOLR_CORE_NAME}/conf/solrconfig.xml
ADD schema.xml /var/solr/data/${SOLR_CORE_NAME}/conf/schema.xml

## 実行コマンド
ENTRYPOINT service solr start && tail -f /dev/null
