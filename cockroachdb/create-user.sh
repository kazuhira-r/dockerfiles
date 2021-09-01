#!/bin/bash

cockroach sql --certs-dir=$CERTS_DIR -e 'create user myuser password "password"; grant admin to myuser;'

echo 'user myuser:password created.'
