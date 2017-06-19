#!/bin/sh

set -e

if [ "$DOCKER_IN_DOCKER" = "start" ] ; then
    dockerd &
fi

exec /run-agent.sh
