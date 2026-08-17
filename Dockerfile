FROM safarov/freeswitch:latest

USER root

# Create TLS directory and generate self-signed cert
RUN mkdir -p /etc/freeswitch/tls /sounds/recordings && \
    openssl req -x509 -newkey rsa:2048 -keyout /etc/freeswitch/tls/key.pem -out /etc/freeswitch/tls/cert.pem -days 3650 -nodes -subj "/CN=srv923799.hstgr.cloud" && \
    cat /etc/freeswitch/tls/cert.pem /etc/freeswitch/tls/key.pem > /etc/freeswitch/tls/agent.pem && \
    cp /etc/freeswitch/tls/cert.pem /etc/freeswitch/tls/cafile.pem

# Copy custom configs
COPY freeswitch/autoload_configs/ /etc/freeswitch/autoload_configs/
COPY freeswitch/sip_profiles/ /etc/freeswitch/sip_profiles/
COPY freeswitch/dialplan/ /etc/freeswitch/dialplan/
COPY freeswitch/vars.xml /etc/freeswitch/vars.xml

EXPOSE 5060/tcp 5060/udp 5061/tcp 5061/udp 8021/tcp 16384-16500/udp

CMD ["freeswitch", "-nc", "-nf"]
