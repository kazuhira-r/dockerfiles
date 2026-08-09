#!/bin/bash

echo 'show configuration conf/keycloak.conf'
echo "\$ grep -vE '^#|^\$' conf/keycloak.conf"
grep -vE '^#|^$' conf/keycloak.conf
echo
echo 'start keycloak...'

echo "\$ bin/kc.sh $@"

bin/kc.sh "$@"
