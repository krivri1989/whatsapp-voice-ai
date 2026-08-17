FROM safarov/freeswitch:latest

# Remove default vanilla profiles that conflict on ports
RUN rm -rf /etc/freeswitch/sip_profiles/* /usr/share/freeswitch/conf/vanilla/sip_profiles/* 2>/dev/null || true

# Copy pre-generated TLS certs
COPY tls/ /etc/freeswitch/tls/
COPY tls/ /usr/share/freeswitch/conf/vanilla/tls/

# Copy custom configs
COPY freeswitch/autoload_configs/ /etc/freeswitch/autoload_configs/
COPY freeswitch/autoload_configs/ /usr/share/freeswitch/conf/vanilla/autoload_configs/

COPY freeswitch/dialplan/ /etc/freeswitch/dialplan/
COPY freeswitch/dialplan/ /usr/share/freeswitch/conf/vanilla/dialplan/

COPY freeswitch/vars.xml /etc/freeswitch/vars.xml
COPY freeswitch/vars.xml /usr/share/freeswitch/conf/vanilla/vars.xml

EXPOSE 5060/tcp 5060/udp 5061/tcp 5061/udp 8021/tcp 16384-16500/udp

CMD ["freeswitch", "-nc", "-nf"]
