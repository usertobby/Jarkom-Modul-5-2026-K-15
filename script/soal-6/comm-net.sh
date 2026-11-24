#!/bin/sh
set -eu

# IP statis, gateway, dan DNS persisten untuk Comm-Net (Debinet), Soal 6.
cat > /etc/network/interfaces <<'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.71.2.2
    netmask 255.255.255.0
    gateway 10.71.2.1
    up echo "nameserver 8.8.8.8" > /etc/resolv.conf
EOF

ifdown --force eth0 2>/dev/null || true
ifup eth0
