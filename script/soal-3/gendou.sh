#!/bin/sh
set -eu

# Konfigurasi interface dan static route router gendou, Soal 3.
# Jalankan di container Debian terkait sebagai root.
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
    up ip route replace 10.71.4.64/29 via 10.71.4.110
    up ip route replace 10.71.3.192/27 via 10.71.4.110
    up ip route replace 10.71.4.80/29 via 10.71.4.110
    up ip route replace 10.71.4.136/29 via 10.71.4.110

auto eth3
iface eth3 inet static
    address 10.71.4.113
    netmask 255.255.255.252
    up ip route replace 10.71.4.88/29 via 10.71.4.114
    up ip route replace 10.71.4.56/29 via 10.71.4.114
    up ip route replace 10.71.4.144/30 via 10.71.4.114

auto eth4
iface eth4 inet static
    address 10.71.4.117
    netmask 255.255.255.252
    up ip route replace 10.71.4.72/29 via 10.71.4.118

auto eth5
iface eth5 inet static
    address 10.71.4.121
    netmask 255.255.255.252
    up ip route replace 10.71.4.100/30 via 10.71.4.122

auto eth6
iface eth6 inet static
    address 10.71.4.125
    netmask 255.255.255.252
    up ip route replace 10.71.4.96/30 via 10.71.4.126
    up ip route replace 10.71.4.48/29 via 10.71.4.126
    up ip route replace 10.71.3.128/26 via 10.71.4.126
    up ip route replace 10.71.4.148/30 via 10.71.4.126
    up ip route replace 10.71.4.152/30 via 10.71.4.126

auto eth7
iface eth7 inet static
    address 10.71.4.129
    netmask 255.255.255.252
    up ip route replace 10.71.2.0/24 via 10.71.4.130
    up ip route replace 10.71.3.224/27 via 10.71.4.130
    up ip route replace 10.71.4.156/30 via 10.71.4.130

auto eth8
iface eth8 inet static
    address 10.71.4.133
    netmask 255.255.255.252
    up ip route replace 10.71.3.0/25 via 10.71.4.134
    up ip route replace 10.71.4.32/28 via 10.71.4.134
    up ip route replace 10.71.0.0/23 via 10.71.4.134
    up ip route replace 10.71.4.0/27 via 10.71.4.134
    up ip route replace 10.71.4.160/29 via 10.71.4.134
    up ip route replace 10.71.4.168/30 via 10.71.4.134
EOF

sysctl -w net.ipv4.ip_forward=1
ifdown --force -a 2>/dev/null || true
ifup -a
