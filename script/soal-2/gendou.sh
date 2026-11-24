#!/bin/sh
set -eu

# Konfigurasi interface router gendou untuk Soal 2.
# Jalankan di container router terkait sebagai root.
cat > /etc/network/interfaces <<'EOF'
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
    up sysctl -w net.ipv4.ip_forward=1

auto eth1
iface eth1 inet static
    address 10.71.4.105
    netmask 255.255.255.252

auto eth2
iface eth2 inet static
    address 10.71.4.109
    netmask 255.255.255.252

auto eth3
iface eth3 inet static
    address 10.71.4.113
    netmask 255.255.255.252

auto eth4
iface eth4 inet static
    address 10.71.4.117
    netmask 255.255.255.252

auto eth5
iface eth5 inet static
    address 10.71.4.121
    netmask 255.255.255.252

auto eth6
iface eth6 inet static
    address 10.71.4.125
    netmask 255.255.255.252

auto eth7
iface eth7 inet static
    address 10.71.4.129
    netmask 255.255.255.252

auto eth8
iface eth8 inet static
    address 10.71.4.133
    netmask 255.255.255.252
EOF

sysctl -w net.ipv4.ip_forward=1
ifdown --force -a 2>/dev/null || true
ifup -a
