#!/bin/bash

if [ "$1" == "master" ]; then
    grep 'SOLR_OPTS="$SOLR_OPTS -Dsolr.repl.master=true"' /var/solr/solr.in.sh || \
        echo 'SOLR_OPTS="$SOLR_OPTS -Dsolr.repl.master=true"' >> /var/solr/solr.in.sh
elif [ "$1" == "slave" ]; then
    grep 'SOLR_OPTS="$SOLR_OPTS -Dsolr.repl.slave=true"' /var/solr/solr.in.sh || \
        echo 'SOLR_OPTS="$SOLR_OPTS -Dsolr.repl.slave=true"' >> /var/solr/solr.in.sh
else
    echo "require argument 'master' or 'slave'"
    exit 1
fi

service solr start && tail -f /dev/null
