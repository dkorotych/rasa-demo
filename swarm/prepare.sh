#!/usr/bin/env bash

set -e
set -u

CURRENT_DIRECTORY=$(pwd)

cd "$(dirname $0)/.."
docker build --tag sara-ui --file swarm/Dockerfile-ui .
docker build --tag sara-bot --file swarm/Dockerfile-bot .
docker build --tag sara-actions .

cd "$CURRENT_DIRECTORY"
