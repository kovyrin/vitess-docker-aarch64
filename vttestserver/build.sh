#!/usr/bin/env bash

set -ex

DOCKER_BIN=$(which podman || which docker)
if [ -z "${DOCKER_BIN}" ]; then
    echo "ERROR: podman or docker not found"
    exit 1
fi

MYSQL_FLAVOR=${1:-"mysql80"}
TAG="vttestserver-${MYSQL_FLAVOR}"
DOCKERFILE=Dockerfile.${MYSQL_FLAVOR}-arm64v8

exec ${DOCKER_BIN} build -t ${TAG} -f ${DOCKERFILE} .
