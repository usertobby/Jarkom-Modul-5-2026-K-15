#!/bin/sh
set -eu

# Konfigurasi interface dan static route router yui, Soal 3.
# Jalankan di container Debian terkait sebagai root.
cat > /etc/network/interfaces <<'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.71.4.134
    netmask 255.255.255.252
    up sysctl -w net.ipv4.ip_forward=1
    up ip route replace default via 10.71.4.133

auto eth1
iface eth1 inet static
    address 10.71.3.1
    netmask 255.255.255.128

auto eth2
iface eth2 inet static
    address 10.71.4.161
    netmask 255.255.255.252
    up ip route replace 10.71.4.32/28 via 10.71.4.162

auto eth3
iface eth3 inet static
    address 10.71.4.165
    netmask 255.255.255.252
    up ip route replace 10.71.0.0/23 via 10.71.4.166

auto eth4
iface eth4 inet static
    address 10.71.4.169
    netmask 255.255.255.252
    up ip route replace 10.71.4.0/27 via 10.71.4.170
EOF

sysctl -w net.ipv4.ip_forward=1
ifdown --force -a 2>/dev/null || true
ifup -a
