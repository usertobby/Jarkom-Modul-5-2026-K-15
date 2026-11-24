#!/bin/sh
set -eu

# Konfigurasi interface router kensuke untuk Soal 2.
# Jalankan di container router terkait sebagai root.
cat > /etc/network/interfaces <<'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.71.4.154
    netmask 255.255.255.252
    up sysctl -w net.ipv4.ip_forward=1

auto eth1
iface eth1 inet static
    address 10.71.3.129
    netmask 255.255.255.192
EOF

sysctl -w net.ipv4.ip_forward=1
ifdown --force -a 2>/dev/null || true
ifup -a
