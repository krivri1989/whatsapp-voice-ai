#!/bin/sh
set -e
echo "[init] Writing FreeSWITCH configs..."

# Generate self-signed TLS cert
mkdir -p /certs
openssl req -x509 -newkey rsa:4096 -keyout /certs/key.pem -out /certs/cert.pem \
  -days 3650 -nodes -subj "/CN=srv923799.hstgr.cloud" 2>/dev/null
cat /certs/cert.pem /certs/key.pem > /certs/agent.pem
echo "[init] TLS cert generated"

# Copy configs from baked-in files
cp -r /freeswitch/* /conf/
mkdir -p /sounds/recordings

echo "[init] Done. Configs written to /conf"
tail -f /dev/null
