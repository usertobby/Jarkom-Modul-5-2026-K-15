cat > /root/balthasar.sh << 'EOF'
#!/bin/sh
add() { iptables -C INPUT "$@" 2>/dev/null || iptables -A INPUT "$@"; }

P="-p tcp -m multiport --dports 5000,5001"
add $P -s 10.71.4.66   -j ACCEPT
add $P -s 10.71.4.74/31 -j ACCEPT
add $P -s 10.71.4.76   -j ACCEPT
add $P -s 10.71.3.130  -j ACCEPT
add $P -j REJECT --reject-with tcp-reset
EOF
chmod +x /root/balthasar.sh
/root/balthasar.sh
iptables -L INPUT -n -v --line-numbers