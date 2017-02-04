#!/bin/bash

## use
# --protected-mode no
bin/redis-server --bind `hostname -i` --requirepass redispass "$@"
