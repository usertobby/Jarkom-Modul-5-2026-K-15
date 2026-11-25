# Rute statis (soal 3), dipakai juga untuk pemulihan soal 20
ip route replace 10.71.4.56/29 via 10.71.4.146 dev eth2
ip route replace default via 10.71.4.113 dev eth0