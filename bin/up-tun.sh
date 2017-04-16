#!/bin/sh
set -e

gateway=$1
srv_net=$2
eth=$3
tun=$4
table=vpn

echo 1 > /proc/sys/net/ipv4/conf/${eth}/proxy_arp
echo -e "1\t${table}" >> /etc/iproute2/rt_tables
ip addr flush dev ${eth}
ip route flush table ${table}
ip rule add dev ${tun} table ${table}
ip rule add dev ${eth} table ${table}
ip route add ${srv_net} dev ${tun} table ${table}
ip route add ${gateway}/32 dev ${eth} table ${table}
ip route add default via ${gateway} dev ${eth} table ${table}
