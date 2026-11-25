#!/bin/sh
# Soal 18: gerbang zona Monolith dan Radar
UPLINK="eth0"                # interface Shigeru yang menghadap Gendo
TERMINAL="10.71.4.64/29"     # subnet Switch-Terminal

iptables -N ZONA 2>/dev/null
iptables -F ZONA
iptables -A ZONA -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A ZONA -i $UPLINK -s $TERMINAL -p icmp --icmp-type echo-request -j ACCEPT
iptables -A ZONA -i $UPLINK -j DROP

iptables -C FORWARD -j ZONA 2>/dev/null || iptables -A FORWARD -j ZONA