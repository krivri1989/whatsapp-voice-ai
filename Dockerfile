FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies, OpenSSL, curl, and FreeSWITCH
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg2 \
    openssl \
    python3 \
    && curl -sSL https://files.freeswitch.org/repo/deb/debian-release/freeswitch-meta-all.key | gpg --dearmor -o /usr/share/keyrings/freeswitch-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/freeswitch-keyring.gpg] http://files.freeswitch.org/repo/deb/debian-release/ bookworm main" > /etc/apt/sources.list.d/freeswitch.list \
    && apt-get update \
    && (apt-get install -y --no-install-recommends freeswitch freeswitch-meta-vanilla freeswitch-mod-opus freeswitch-mod-tone-stream freeswitch-mod-sndfile || true) \
    && rm -rf /var/lib/apt/lists/*

# Copy pre-generated TLS certs (fallback)
COPY tls/ /etc/freeswitch/tls/

# Copy custom configs
COPY freeswitch/autoload_configs/ /etc/freeswitch/autoload_configs/
COPY freeswitch/sip_profiles/ /etc/freeswitch/sip_profiles/
COPY freeswitch/dialplan/ /etc/freeswitch/dialplan/
COPY freeswitch/vars.xml /etc/freeswitch/vars.xml
COPY freeswitch/freeswitch.xml /etc/freeswitch/freeswitch.xml

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && mkdir -p /var/log/freeswitch /var/run/freeswitch /sounds/recordings

EXPOSE 5060/tcp 5060/udp 5061/tcp 5061/udp 8021/tcp 16384-16500/udp

ENTRYPOINT ["/entrypoint.sh"]
