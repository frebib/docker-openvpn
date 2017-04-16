#!/bin/sh
set -e

bridge=$1
eth=$2

brctl addbr ${bridge}
brctl addif ${bridge} ${eth}
brctl addif ${bridge} ${dev}
ip addr flush dev ${eth}
ip link set ${bridge} up
ip link set ${dev} up
