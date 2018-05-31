#!/bin/bash

if [ ! -z "$OPTION_LIBS" ]; then
  IFS=, LIBS_LIST=("$OPTION_LIBS")

  for lib in ${LIBS_LIST[@]}; do
    cp -r /opt/apache-ignite-fabric-bin/libs/optional/"$lib"/* /opt/apache-ignite-fabric-bin/libs/
  done
fi

bin/ignite.sh
