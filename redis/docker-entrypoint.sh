#!/bin/bash

## use
# --protected-mode no
bin/redis-server --bind '0.0.0.0' --requirepass ${REDIS_PASSWORD} "$@"
