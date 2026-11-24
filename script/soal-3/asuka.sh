#!/bin/sh
set -eu

# Konfigurasi interface dan static route router asuka, Soal 3.
# Jalankan di container Debian terkait sebagai root.
cat > /etc/network/interfaces <<'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.71.4.126
    netmask 255.255.255.252
    up sysctl -w net.ipv4.ip_forward=1
    up ip route replace default via 10.71.4.125

auto eth1
iface eth1 inet static
    address 10.71.4.97
    netmask 255.255.255.252

auto eth2
iface eth2 inet static
    address 10.71.4.149
    netmask 255.255.255.252
    up ip route replace 10.71.4.48/29 via 10.71.4.150

auto eth3
iface eth3 inet static
    address 10.71.4.153
    netmask 255.255.255.252
    up ip route replace 10.71.3.128/26 via 10.71.4.154
EOF

sysctl -w net.ipv4.ip_forward=1
ifdown --force -a 2>/dev/null || true
ifup -a
