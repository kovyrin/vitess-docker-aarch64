#!/usr/bin/env bash

set -ex

source versions.sh

DOCKER_BIN=$(which podman || which docker)
if [ -z "${DOCKER_BIN}" ]; then
    echo "ERROR: podman or docker not found"
    exit 1
fi

MYSQL_FLAVOR=${1:-"mysql80"}
TAG="kovyrin/vttestserver-arm64v8:mysql-${MYSQL_VERSION}-vitess-${VITESS_VERSION}"
DOCKERFILE=Dockerfile.${MYSQL_FLAVOR}-arm64v8

exec ${DOCKER_BIN} build \
    --build-arg vitess_version=${VITESS_VERSION} \
    --build-arg mysql_version=${MYSQL_VERSION} \
    --build-arg go_version=${GO_VERSION} \
    --build-arg BUILD_NUMBER=${BUILD_NUMBER} \
    -t ${TAG} \
    -f ${DOCKERFILE} .
