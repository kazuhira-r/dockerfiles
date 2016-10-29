#!/bin/bash

if [ "$1" != "" ]; then
    ELASTICSEARCH_URL=$1
else
    ELASTICSEARCH_URL=http://localhost:9200
fi

perl -wpi -e 's!(.*)elasticsearch.url:.+!elasticsearch.url: "'${ELASTICSEARCH_URL}'"!' /etc/kibana/kibana.yml

perl -wpi -e 's!^#server.host:.+!server.host: 0.0.0.0!' /etc/kibana/kibana.yml

echo >> /etc/kibana/kibana.yml

service kibana start && tail -f /dev/null
