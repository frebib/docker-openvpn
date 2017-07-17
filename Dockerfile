FROM alpine:3.6
MAINTAINER Joe Groocock <frebib@gmail.com>

RUN apk add --no-cache openvpn iptables bridge-utils tini tcpdump easy-rsa && \
    ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin

# Needed by scripts
ENV OPENVPN=/etc/openvpn \
    OPENVPN_PKI=$OPENVPN/pki \
# Default configuration
    CONFIG_FILE=$OPENVPN/openvpn.conf \
    TAP_BRIDGE=ovpn TUNTAP_ETH=eth1

VOLUME [ "/etc/openvpn" ]

# Internally uses port 1194/udp, remap using `docker run -p 443:1194/tcp`
EXPOSE 1194/udp

COPY bin/* /usr/local/bin/
RUN chmod +x /usr/local/bin/*

ENTRYPOINT [ "/sbin/tini", "--" ]
CMD [ "/usr/local/bin/ovpn-run" ]
