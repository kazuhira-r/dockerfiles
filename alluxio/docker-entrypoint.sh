#!/bin/bash

cp conf/alluxio-site.properties.template conf/alluxio-site.properties
perl -wpi -e 's!# alluxio.master.hostname=!alluxio.master.hostname=!' conf/alluxio-site.properties

bin/alluxio format
bin/alluxio-start.sh local

tail -f logs/*.log
