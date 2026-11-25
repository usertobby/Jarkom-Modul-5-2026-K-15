cat > /root/penpen.sh << 'EOF'
#!/bin/sh
# ===== Jadwal (WIB) =====
PILOT_START="08:00"
PILOT_STOP="16:00"
PILOT_DAYS="Mon,Tue,Wed,Thu,Fri"
STAF_START="17:00"
STAF_STOP="23:00"

# ===== Anggota kelompok =====
PILOT="10.71.4.74,10.71.4.75,10.71.4.76,10.71.3.130"
STAF="10.71.4.82,10.71.4.83"
TERDUGA="10.71.4.50,10.71.4.51,10.71.4.102"

# WIB -> UTC (dikurangi 7 jam)
to_utc() { h=${1%%:*}; m=${1#*:}; h=${h#0}; printf "%02d:%s" $(( (h + 17) % 24 )) "$m"; }

# Chain khusus, dikosongkan setiap script dijalankan
iptables -N PENPEN 2>/dev/null
iptables -F PENPEN

# Arahkan ping masuk dan TCP 80 ke chain PENPEN (sekali saja)
iptables -C INPUT -p icmp --icmp-type echo-request -j PENPEN 2>/dev/null || \
  iptables -A INPUT -p icmp --icmp-type echo-request -j PENPEN
iptables -C INPUT -p tcp --dport 80 -j PENPEN 2>/dev/null || \
  iptables -A INPUT -p tcp --dport 80 -j PENPEN

# Terduga: selalu ditolak
iptables -A PENPEN -s $TERDUGA -j DROP

# Pilot: hanya sesuai jadwal
iptables -A PENPEN -s $PILOT -m time --timestart $(to_utc $PILOT_START) \
  --timestop $(to_utc $PILOT_STOP) --weekdays $PILOT_DAYS -j ACCEPT
iptables -A PENPEN -s $PILOT -j DROP

# Staf: hanya sesuai jadwal
iptables -A PENPEN -s $STAF -m time --timestart $(to_utc $STAF_START) \
  --timestop $(to_utc $STAF_STOP) -j ACCEPT
iptables -A PENPEN -s $STAF -j DROP

# Lainnya: tidak kena rule apa pun, jadi diterima policy INPUT
EOF
chmod +x /root/penpen.sh