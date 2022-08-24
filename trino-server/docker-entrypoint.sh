#!/bin/bash

IP_ADDRESS=$(hostname -i)

perl -wp -i -e 's!discovery.uri=http://localhost:8080!discovery.uri=http://'${IP_ADDRESS}':8080!' etc/config.properties 

bin/launcher run

