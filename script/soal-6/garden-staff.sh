#!/bin/sh
set -eu

# IP statis, gateway, dan DNS persisten untuk Garden-Staff (Debinet), Soal 6.
cat > /etc/network/interfaces <<'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.71.4.2
    netmask 255.255.255.224
    gateway 10.71.4.1
    up echo "nameserver 8.8.8.8" > /etc/resolv.conf
EOF

ifdown --force eth0 2>/dev/null || true
ifup eth0
