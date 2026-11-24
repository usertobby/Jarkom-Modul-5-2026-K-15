#!/bin/sh
set -eu

sleep 2

# Soal 2: aktifkan IP forwarding.
sysctl -w net.ipv4.ip_forward=1

# Soal 3: rute statis dan ringkasan subnet.
# Cabang Fuyutsuki.
ip route replace 10.71.4.64/29 via 10.71.4.110
ip route replace 10.71.3.192/27 via 10.71.4.110
ip route replace 10.71.4.80/29 via 10.71.4.110
ip route replace 10.71.4.136/29 via 10.71.4.110

# Cabang Shigeru.
ip route replace 10.71.4.88/29 via 10.71.4.114
ip route replace 10.71.4.56/29 via 10.71.4.114
ip route replace 10.71.4.144/30 via 10.71.4.114

# Cabang Misato dan Kaji.
ip route replace 10.71.4.72/29 via 10.71.4.118
ip route replace 10.71.4.100/30 via 10.71.4.122

# Cabang Asuka.
ip route replace 10.71.4.96/30 via 10.71.4.126
ip route replace 10.71.4.48/29 via 10.71.4.126
ip route replace 10.71.3.128/26 via 10.71.4.126
ip route replace 10.71.4.148/30 via 10.71.4.126
ip route replace 10.71.4.152/30 via 10.71.4.126

# Cabang Hikari.
ip route replace 10.71.2.0/24 via 10.71.4.130
ip route replace 10.71.3.224/27 via 10.71.4.130
ip route replace 10.71.4.156/30 via 10.71.4.130

# Cabang Yui.
ip route replace 10.71.3.0/25 via 10.71.4.134
ip route replace 10.71.4.32/28 via 10.71.4.134
ip route replace 10.71.0.0/23 via 10.71.4.134
ip route replace 10.71.4.0/27 via 10.71.4.134
ip route replace 10.71.4.160/29 via 10.71.4.134
ip route replace 10.71.4.168/30 via 10.71.4.134

# Soal 4: NAT hanya untuk jaringan internal menuju NAT1 melalui eth0.
iptables -t nat -F
iptables -t nat -A POSTROUTING -s 10.71.0.0/16 -o eth0 -j MASQUERADE

# Soal 5: reset rule filter, lalu gunakan policy default yang ketat.
iptables -F
iptables -X
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# INPUT: loopback, balasan koneksi, DHCP reply, dan akses dari LAN ke Gendo.
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -i eth0 -p udp --sport 67 --dport 68 -j ACCEPT
iptables -A INPUT ! -i eth0 -s 10.71.0.0/16 -j ACCEPT

# FORWARD: balasan koneksi, LAN ke internet, dan komunikasi antar-LAN.
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD ! -i eth0 -s 10.71.0.0/16 -o eth0 -j ACCEPT
iptables -A FORWARD ! -i eth0 -s 10.71.0.0/16 ! -o eth0 -d 10.71.0.0/16 -j ACCEPT
