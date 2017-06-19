#!/bin/sh

dockerd &
exec /run-agent.sh
