#!/bin/sh
set -e

echo "[entrypoint] Starting FreeSWITCH via docker-entrypoint..."
exec /docker-entrypoint.sh freeswitch
