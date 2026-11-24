#!/bin/sh
set -eu

# Bersihkan rule NAT lama agar rule tidak terduplikasi.
iptables -t nat -F POSTROUTING

# Hanya NAT traffic dari jaringan internal yang keluar melalui eth0 ke NAT1.
iptables -t nat -A POSTROUTING -s 10.71.0.0/16 -o eth0 -j MASQUERADE
