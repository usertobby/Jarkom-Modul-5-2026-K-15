#!/bin/sh
# Soal 15: batas ping ke Tokyo3-Core
LIMIT="5/second"
BURST="5"

iptables -N PINGLIMIT 2>/dev/null
iptables -F PINGLIMIT
iptables -A PINGLIMIT -m limit --limit $LIMIT --limit-burst $BURST -j ACCEPT
iptables -A PINGLIMIT -j DROP

# Jump dipasang di posisi paling atas INPUT, hanya untuk ping masuk
iptables -C INPUT -p icmp --icmp-type echo-request -j PINGLIMIT 2>/dev/null || iptables -I INPUT 1 -p icmp --icmp-type echo-request -j PINGLIMIT

# Soal 16: catat dan tolak scan dari Dummy-Plug
DUMMY="10.71.4.51"
SCAN_PORTS="22,23,3306"

iptables -N SCANNERV 2>/dev/null
iptables -F SCANNERV
iptables -A SCANNERV -p tcp --syn -j LOG --log-prefix "SCAN-NERV: "
iptables -A SCANNERV -p tcp -j REJECT --reject-with tcp-reset

iptables -C INPUT -p tcp -s $DUMMY -m multiport --dports $SCAN_PORTS -j SCANNERV 2>/dev/null || iptables -A INPUT -p tcp -s $DUMMY -m multiport --dports $SCAN_PORTS -j SCANNERV