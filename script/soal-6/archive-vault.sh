#!/bin/sh
set -eu

# IP statis, gateway, dan DNS persisten untuk Archive-Vault (Debinet), Soal 6.
cat > /etc/network/interfaces <<'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.71.4.98
    netmask 255.255.255.252
    gateway 10.71.4.97
    up echo "nameserver 8.8.8.8" > /etc/resolv.conf
EOF

ifdown --force eth0 2>/dev/null || true
ifup eth0
