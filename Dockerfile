FROM safarov/freeswitch:latest

# Copy pre-generated TLS certs (generated with domain srv923799.hstgr.cloud)
COPY tls/ /etc/freeswitch/tls/
COPY tls/ /usr/share/freeswitch/conf/vanilla/tls/

# Copy custom configs
COPY freeswitch/autoload_configs/ /etc/freeswitch/autoload_configs/
COPY freeswitch/autoload_configs/ /usr/share/freeswitch/conf/vanilla/autoload_configs/

COPY freeswitch/dialplan/ /etc/freeswitch/dialplan/
COPY freeswitch/dialplan/ /usr/share/freeswitch/conf/vanilla/dialplan/

COPY freeswitch/vars.xml /etc/freeswitch/vars.xml
COPY freeswitch/vars.xml /usr/share/freeswitch/conf/vanilla/vars.xml

COPY entrypoint.sh /entrypoint.sh

EXPOSE 5060/tcp 5060/udp 5061/tcp 5061/udp 8021/tcp 16384-16500/udp

ENTRYPOINT ["/entrypoint.sh"]
