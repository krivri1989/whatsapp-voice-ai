FROM safarov/freeswitch:latest

# Copy pre-generated TLS certs to both /etc/freeswitch/tls and /usr/share/freeswitch/conf/vanilla/tls
COPY tls/ /etc/freeswitch/tls/
COPY tls/ /usr/share/freeswitch/conf/vanilla/tls/

# Copy custom configs to both locations so entrypoint does not overwrite them with defaults
COPY freeswitch/autoload_configs/ /etc/freeswitch/autoload_configs/
COPY freeswitch/autoload_configs/ /usr/share/freeswitch/conf/vanilla/autoload_configs/

COPY freeswitch/sip_profiles/ /etc/freeswitch/sip_profiles/
COPY freeswitch/sip_profiles/ /usr/share/freeswitch/conf/vanilla/sip_profiles/

COPY freeswitch/dialplan/ /etc/freeswitch/dialplan/
COPY freeswitch/dialplan/ /usr/share/freeswitch/conf/vanilla/dialplan/

COPY freeswitch/vars.xml /etc/freeswitch/vars.xml
COPY freeswitch/vars.xml /usr/share/freeswitch/conf/vanilla/vars.xml

EXPOSE 5060/tcp 5060/udp 5061/tcp 5061/udp 8021/tcp 16384-16500/udp

CMD ["freeswitch", "-nc", "-nf"]
