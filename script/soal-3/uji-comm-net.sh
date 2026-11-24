#!/bin/sh
set -eu

# Konfigurasi IP sementara untuk pengujian Soal 3 pada container Debian.
ip addr flush dev eth0
ip addr add 10.71.2.2/24 dev eth0
ip link set eth0 up
ip route replace default via 10.71.2.1
