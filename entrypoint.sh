#!/bin/sh
set -e

echo "[entrypoint] Starting FreeSWITCH with configured TLS..."
exec freeswitch -nc -nf
