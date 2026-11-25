#!/bin/sh
# Soal 19: tolak semua lalu lintas dengan Armisael (tetangga satu switch, tidak lewat Shigeru)
ARMISAEL="10.71.4.91"
iptables -C INPUT -s $ARMISAEL -j DROP 2>/dev/null || iptables -I INPUT 1 -s $ARMISAEL -j DROP
iptables -C OUTPUT -d $ARMISAEL -j DROP 2>/dev/null || iptables -I OUTPUT 1 -d $ARMISAEL -j DROP