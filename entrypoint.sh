#!/bin/sh
set -e

echo "[entrypoint] Checking for Let's Encrypt certs in /le-certs..."

if [ -f "/le-certs/cert.pem" ] && [ -f "/le-certs/key.pem" ]; then
  echo "[entrypoint] Found Let's Encrypt certs, installing to vanilla source..."
  mkdir -p /usr/share/freeswitch/conf/vanilla/tls
  cp /le-certs/cert.pem /usr/share/freeswitch/conf/vanilla/tls/cert.pem
  cp /le-certs/key.pem /usr/share/freeswitch/conf/vanilla/tls/key.pem
  cp /le-certs/agent.pem /usr/share/freeswitch/conf/vanilla/tls/agent.pem
  cp /le-certs/cafile.pem /usr/share/freeswitch/conf/vanilla/tls/cafile.pem
  echo "[entrypoint] Let's Encrypt certs installed to vanilla source!"
else
  echo "[entrypoint] No Let's Encrypt certs found, using fallback self-signed certs"
fi

echo "[entrypoint] Starting FreeSWITCH..."
# Suppress docker-entrypoint file copy noise, keep FreeSWITCH logs visible
exec /docker-entrypoint.sh freeswitch 2>&1 | grep -v "^'/usr/share"
