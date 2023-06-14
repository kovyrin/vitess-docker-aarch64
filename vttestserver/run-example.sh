#!/usr/bin/env bash

set -x

VITESS_BASE_PORT=15300
VITESS_VTGATE_PORT=15301
VITESS_MYSQL_PORT=15302
VITESS_VTCOMBO_PORT=15303

VITESS_KEYSPACES="commerce,sharded"
VITESS_NUM_SHARDS="1,2"

source versions.sh
TAG="kovyrin/vttestserver-arm64v8:mysql-${MYSQL_VERSION}-vitess-${VITESS_VERSION}"

DOCKER_BIN=$(which podman || which docker)
if [ -z "${DOCKER_BIN}" ]; then
    echo "ERROR: podman or docker not found"
    exit 1
fi

FIRST_KEYSPACE=$(echo ${VITESS_KEYSPACES} | cut -d ',' -f 1)

${DOCKER_BIN} run -it --rm \
    --name vttestserver-mac \
    --platform linux/arm64 \
    --publish ${VITESS_BASE_PORT}:${VITESS_BASE_PORT} \
    --publish ${VITESS_VTGATE_PORT}:${VITESS_VTGATE_PORT} \
    --publish ${VITESS_MYSQL_PORT}:${VITESS_MYSQL_PORT} \
    --publish ${VITESS_VTCOMBO_PORT}:${VITESS_VTCOMBO_PORT} \
    --env PORT=${VITESS_BASE_PORT} \
    --env KEYSPACES="${VITESS_KEYSPACES}" \
    --env NUM_SHARDS="${VITESS_NUM_SHARDS}" \
    --env MYSQL_MAX_CONNECTIONS=10000 \
    --env MYSQL_BIND_HOST="0.0.0.0" \
    --health-cmd "mysql --host 127.0.0.1 --port ${VITESS_VTCOMBO_PORT} ${FIRST_KEYSPACE} -e 'SHOW TABLES'" \
    --health-interval "5s" \
    --health-timeout "2s" \
    --health-retries 5 \
    ${TAG}
