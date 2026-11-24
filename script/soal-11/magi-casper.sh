#!/bin/sh

# ini versi ghost buat soal 11 ya
if ! command -v iptables >/dev/null 2>&1 || ! command -v nc >/dev/null 2>&1; then
    DATE_STR=$(wget -S --spider http://deb.debian.org 2>&1 | awk -F': ' '/^  Date:/{print $2; exit}')
    [ -n "$DATE_STR" ] && date -s "$DATE_STR"
    apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -y -qq iptables netcat-openbsd
fi

# Bersihkan aturan lama agar tidak duplikat saat skrip dijalankan ulang
iptables -F INPUT

# Izinkan balasan koneksi/ping yang dimulai oleh Casper sendiri
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Blokir semua ping (ICMP echo-request) yang masuk ke Casper
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

# Pastikan listener TCP 5000 Casper tetap hidup
pkill -f "[n]c -l 5000" 2>/dev/null || true
pkill -f "[n]c -l -p 5000" 2>/dev/null || true
nohup nc -l 5000 >/root/casper-5000.log 2>&1 &