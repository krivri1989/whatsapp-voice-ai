FROM safarov/freeswitch:latest

# Copy pre-generated TLS certs
COPY tls/ /etc/freeswitch/tls/

# Copy custom configs
COPY freeswitch/autoload_configs/ /etc/freeswitch/autoload_configs/
COPY freeswitch/sip_profiles/ /etc/freeswitch/sip_profiles/
COPY freeswitch/dialplan/ /etc/freeswitch/dialplan/
COPY freeswitch/vars.xml /etc/freeswitch/vars.xml

EXPOSE 5060/tcp 5060/udp 5061/tcp 5061/udp 8021/tcp 16384-16500/udp

CMD ["freeswitch", "-nc", "-nf"]
