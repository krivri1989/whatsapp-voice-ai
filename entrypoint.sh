#!/bin/sh
set -e

echo "[entrypoint] Checking for Let's Encrypt certs in /traefik_data/acme.json..."

if [ -f "/traefik_data/acme.json" ]; then
  echo "[entrypoint] Found acme.json, extracting certificates..."
  python3 -c '
import json, base64, os

try:
    with open("/traefik_data/acme.json", "r") as f:
        data = json.load(f)
    
    certs = []
    for resolver_name, resolver in data.items():
        if isinstance(resolver, dict) and "Certificates" in resolver and resolver["Certificates"]:
            certs = resolver["Certificates"]
            break
    
    if certs:
        cert_data = certs[0]
        cert_pem = base64.b64decode(cert_data["certificate"]).decode("utf-8")
        key_pem = base64.b64decode(cert_data["key"]).decode("utf-8")
        
        os.makedirs("/etc/freeswitch/tls", exist_ok=True)
        with open("/etc/freeswitch/tls/cert.pem", "w") as f: f.write(cert_pem)
        with open("/etc/freeswitch/tls/key.pem", "w") as f: f.write(key_pem)
        with open("/etc/freeswitch/tls/agent.pem", "w") as f: f.write(cert_pem + "\n" + key_pem)
        with open("/etc/freeswitch/tls/cafile.pem", "w") as f: f.write(cert_pem)
        print("[entrypoint] Successfully extracted Let\x27s Encrypt TLS certificate for FreeSWITCH!")
except Exception as e:
    print(f"[entrypoint] Extraction error: {e}")
' || true
fi

echo "[entrypoint] Starting FreeSWITCH..."
exec freeswitch -nc -nf -nonat
