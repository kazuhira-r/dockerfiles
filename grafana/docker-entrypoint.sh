#!/bin/bash

cd /usr/share/grafana

LOG_DIR=/var/log/grafana
DATA_DIR=/var/lib/grafana
PLUGINS_DIR=/var/lib/grafana/plugins
PROVISIONING_CFG_DIR=/etc/grafana/provisioning

sudo -u grafana /usr/share/grafana/bin/grafana server                                     \
                            --config=${CONF_FILE}                                   \
                            --packaging=deb                                         \
                            cfg:default.paths.logs=${LOG_DIR}                       \
                            cfg:default.paths.data=${DATA_DIR}                      \
                            cfg:default.paths.plugins=${PLUGINS_DIR}                \
                            cfg:default.paths.provisioning=${PROVISIONING_CFG_DIR}
