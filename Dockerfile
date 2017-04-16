FROM alpine:3.5
MAINTAINER Joe Groocock <frebib@gmail.com>

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories && \
    echo "http://dl-4.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
    apk add --no-cache openvpn iptables bridge-utils tcpdump && \
    ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin

# Needed by scripts
ENV OPENVPN /etc/openvpn
ENV OPENVPN_PKI $OPENVPN/pki

# Default configuration
ENV CONFIG_FILE $OPENVPN/openvpn.conf
ENV TAP_BRIDGE=ovpn TUNTAP_ETH=eth1

VOLUME [ "/etc/openvpn" ]

# Internally uses port 1194/udp, remap using `docker run -p 443:1194/tcp`
EXPOSE 1194/udp

CMD [ "/usr/local/bin/ovpn-run" ]

COPY bin/* /usr/local/bin/
