#!/bin/sh
if ! command -v iptables >/dev/null 2>&1 || ! command -v nc >/dev/null 2>&1; then
    DATE_STR=$(wget -S --spider http://deb.debian.org 2>&1 | awk -F': ' '/^  Date:/{print $2; exit}')
    [ -n "$DATE_STR" ] && date -s "$DATE_STR"
    apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -y -qq iptables netcat-openbsd
fi

pkill -f "[n]c -l 80" 2>/dev/null || true

while true; do
    printf "Welcome to %s\n" "$(hostname)" | nc -l 80 >>/root/penpen-80.log 2>&1 || sleep 1
done &
