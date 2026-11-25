# Soal 19: isolasi Armisael (jalur lewat Shigeru: ke luar subnet dan ke gateway)
ARMISAEL="10.71.4.91"

iptables -N ISOLASI 2>/dev/null
iptables -F ISOLASI
iptables -A ISOLASI -s $ARMISAEL -j DROP
iptables -A ISOLASI -d $ARMISAEL -j DROP

# Jump di posisi paling atas, di atas ZONA (soal 18)
for CH in FORWARD INPUT OUTPUT; do
  iptables -C $CH -j ISOLASI 2>/dev/null || iptables -I $CH 1 -j ISOLASI
done