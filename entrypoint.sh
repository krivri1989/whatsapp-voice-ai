#!/bin/sh
set -e

echo "[entrypoint] Checking for Let's Encrypt certs in /le-certs..."

if [ -f "/le-certs/cert.pem" ] && [ -f "/le-certs/key.pem" ]; then
  echo "[entrypoint] Found Let's Encrypt certs, installing..."
  mkdir -p /etc/freeswitch/tls
  cp /le-certs/cert.pem /etc/freeswitch/tls/cert.pem
  cp /le-certs/key.pem /etc/freeswitch/tls/key.pem
  cp /le-certs/agent.pem /etc/freeswitch/tls/agent.pem
  cp /le-certs/cafile.pem /etc/freeswitch/tls/cafile.pem
  echo "[entrypoint] Let's Encrypt certs installed successfully!"
else
  echo "[entrypoint] No Let's Encrypt certs found, using fallback self-signed certs"
fi

echo "[entrypoint] Starting FreeSWITCH..."
exec /docker-entrypoint.sh freeswitch
