#!/bin/sh

sysctl -w net.ipv4.ip_forward=1

ip rule del iif eth1 lookup 100 priority 90 2>/dev/null || true
ip route flush table 100 2>/dev/null || true
ip route del blackhole 10.71.4.72/29 2>/dev/null || true

ip route replace default via 10.71.4.113 dev eth0
ip route replace 10.71.4.56/29 via 10.71.4.146 dev eth2
