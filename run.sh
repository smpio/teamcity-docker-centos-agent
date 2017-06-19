#!/bin/sh

if [ "$DOCKER_IN_DOCKER" = "start" ] ; then
    dockerd &
fi

exec /run-agent.sh
