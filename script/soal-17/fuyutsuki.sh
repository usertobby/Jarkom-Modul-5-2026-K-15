#!/bin/sh
# DNS dan tool conntrack
echo "nameserver 8.8.8.8" > /etc/resolv.conf
which conntrack >/dev/null || (apt-get update && apt-get install -y conntrack)

# Soal 17: alihkan setiap koneksi TCP Casper -> Zeruel ke Pen-Pen
CASPER="10.71.4.66"
ZERUEL="10.71.4.90"
PENPEN="10.71.3.194"

iptables -t nat -C PREROUTING -p tcp -s $CASPER -d $ZERUEL -j DNAT --to-destination $PENPEN 2>/dev/null || iptables -t nat -A PREROUTING -p tcp -s $CASPER -d $ZERUEL -j DNAT --to-destination $PENPEN