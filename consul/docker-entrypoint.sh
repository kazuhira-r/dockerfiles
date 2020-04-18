#!/bin/bash

sudo service rsyslog start

/opt/consul/consul agent "$@"
