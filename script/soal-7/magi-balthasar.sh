#!/bin/sh
if ! command -v iptables >/dev/null 2>&1 || ! command -v nc >/dev/null 2>&1; then
    DATE_STR=$(wget -S --spider http://deb.debian.org 2>&1 | awk -F': ' '/^  Date:/{print $2; exit}')
    [ -n "$DATE_STR" ] && date -s "$DATE_STR"
    apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -y -qq iptables netcat-traditional
fi

pkill -f "[n]c -l -p 5000" 2>/dev/null || true
pkill -f "[n]c -l -p 5001" 2>/dev/null || true
nohup nc -l -p 5000 >/root/balthasar-5000.log 2>&1 &
nohup nc -l -p 5001 >/root/balthasar-5001.log 2>&1 &
