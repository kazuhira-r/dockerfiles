#!/bin/bash

curl -H "X-Cockroach-API-Session: $SESSION_TOKEN" --cacert $CERTS_DIR/ca.crt https://localhost:8080$1

echo
echo

echo curl -H "'X-Cockroach-API-Session: $SESSION_TOKEN'" --cacert $CERTS_DIR/ca.crt https://localhost:8080$1

echo

echo curl -H "'X-Cockroach-API-Session: \$SESSION_TOKEN'" --cacert '$CERTS_DIR/ca.crt' https://localhost:8080$1

echo

echo curl -H "'X-Cockroach-API-Session: [SESSION_TOKEN]'" --cacert '[CERTS_DIR]/ca.crt' https://localhost:8080$1
