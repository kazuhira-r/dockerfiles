#!/bin/bash

${GEODE_HOME}/bin/gfsh start locator --name=locator
${GEODE_HOME}/bin/gfsh start server --name=server
