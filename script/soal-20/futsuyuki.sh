# Rute statis (soal 3), dipakai juga untuk pemulihan soal 20
ip route replace 10.71.3.192/27 via 10.71.4.138 dev eth2
ip route replace 10.71.4.80/29 via 10.71.4.142 dev eth3
ip route replace default via 10.71.4.109 dev eth0