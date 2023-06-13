#!/usr/bin/env bash

set -ex

source versions.sh

DOCKER_BIN=$(which podman || which docker)
if [ -z "${DOCKER_BIN}" ]; then
    echo "ERROR: podman or docker not found"
    exit 1
fi

TAG="kovyrin/vttestserver-arm64v8:mysql-${MYSQL_VERSION}-vitess-${VITESS_VERSION}"
${DOCKER_BIN} push ${TAG}
