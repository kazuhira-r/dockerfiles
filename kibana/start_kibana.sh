#!/bin/bash

if [ "$1" != "" ]; then
    ELASTICSEARCH_URL=$1
else
    ELASTICSEARCH_URL=http://localhost:9200
fi

perl -wpi -e 's!(.*)elasticsearch.url:.+!elasticsearch.url: "'${ELASTICSEARCH_URL}'"!' /opt/kibana/config/kibana.yml

echo >> /opt/kibana/config/kibana.yml
echo "sense.defaultServerUrl: ${ELASTICSEARCH_URL}" >> /opt/kibana/config/kibana.yml

service kibana start && tail -f /dev/null
