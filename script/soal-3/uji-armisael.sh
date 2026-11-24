#!/bin/sh
set -eu

# Konfigurasi IP sementara untuk pengujian Soal 3 pada container Debian.
ip addr flush dev eth0
ip addr add 10.71.4.91/29 dev eth0
ip link set eth0 up
ip route replace default via 10.71.4.89
