#!/bin/sh
set -eu

# Konfigurasi interface dan static route router kaji, Soal 3.
# Jalankan di container Debian terkait sebagai root.
cat > /etc/network/interfaces <<'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.71.4.122
    netmask 255.255.255.252
    up sysctl -w net.ipv4.ip_forward=1
    up ip route replace default via 10.71.4.121

auto eth1
iface eth1 inet static
    address 10.71.4.101
    netmask 255.255.255.252
EOF

sysctl -w net.ipv4.ip_forward=1
ifdown --force -a 2>/dev/null || true
ifup -a
