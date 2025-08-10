#!/bin/bash

cd /var/lib/mimir

sudo -u mimir mimir --config.file=/etc/mimir/config.yml \
    --runtime-config.file=/etc/mimir/runtime_config.yml \
    --log.level info
