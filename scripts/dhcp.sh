#!/usr/bin/bash

usage() {
    echo "usage: $0 <iface>"
}

IFACE=$1
if [ -z "$IFACE" ]; then
    usage
    exit 1
fi

setup() {
   sudo ip link set up dev $IFACE
   sudo ip addr add 172.16.0.1/24 dev $IFACE
   sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
   sudo sysctl -w net.ipv4.ip_forward=1
}

cleanup() {
    sudo ip addr del 172.16.0.1/24 dev $IFACE
    sudo ip link set down dev $IFACE
    echo "Cleanup iptables and sysctl pretty pweawse<3:3"
}

setup \
&& sudo dnsmasq \
    --port=0 \
    --no-daemon --interface=$IFACE --bind-interfaces \
    --dhcp-range=172.16.0.128,172.16.0.254,12h \
    --dhcp-option=3,172.16.0.1 \
    --log-queries --log-dhcp \
|| cleanup
