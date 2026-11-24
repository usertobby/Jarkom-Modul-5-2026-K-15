#!/bin/sh
set -eu

# Konfigurasi interface dan static route router fuyutsuki, Soal 3.
# Jalankan di container Debian terkait sebagai root.
cat > /etc/network/interfaces <<'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.71.4.110
    netmask 255.255.255.252
    up sysctl -w net.ipv4.ip_forward=1
    up ip route replace default via 10.71.4.109

auto eth1
iface eth1 inet static
    address 10.71.4.65
    netmask 255.255.255.248

auto eth2
iface eth2 inet static
    address 10.71.4.137
    netmask 255.255.255.252
    up ip route replace 10.71.3.192/27 via 10.71.4.138

auto eth3
iface eth3 inet static
    address 10.71.4.141
    netmask 255.255.255.252
    up ip route replace 10.71.4.80/29 via 10.71.4.142
EOF

sysctl -w net.ipv4.ip_forward=1
ifdown --force -a 2>/dev/null || true
ifup -a
