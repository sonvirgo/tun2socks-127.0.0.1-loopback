# tun2socks-127.0.0.1-loopback
Resolve tun2soxks loopback problem on Linux, when using 127.0.0.1 socks

#!/bin/bash

sudo ip route add default via 192.168.43.1 table 110

sudo ip rule add uidrange 1001-1001 lookup 110 pref 29000

pkexec --user psiphon  ./psiphon-tunnel-core-x86_64  --config psiphone.conf

#!/bin/bash

sudo ip tuntap add mode tun dev tun0

sudo ip addr add 198.18.0.1/15 dev tun0

sudo ip link set dev tun0 up

sudo ip route del default

sudo ip route add default via 198.18.0.1 dev tun0 metric 1

sudo ip route add default via 192.168.43.1 dev enp3s0 metric 10

tun2socks -device tun0 -proxy socks5://127.0.0.1:2088 -interface enp3s0

