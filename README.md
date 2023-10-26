# tun2socks-127.0.0.1-loopback

Resolve tun2socks loopback problem on Linux and Windows 11, when using 127.0.0.1 socks

Possible to use uidrange or cgroup by policy based rouitng in Linux

Done!

I change my Wifi card.

Also disable systemd-resolve.

Some how it works.

Don't know the cause, however.

Now tun2socks work as NAT Router, beautifully forwarding Ethernet to Wifi TUN interface, both in Linux and Windows.

Can't figure out how to make it work on Darwin, as loopback is not resolved in macOS.

#!/bin/bash

sudo ip tuntap add mode tun dev tun0

sudo ip addr add 198.18.0.1/15 dev tun0

sudo ip link set dev tun0 up

sudo ip route del default

sudo ip route add default via 198.18.0.1 dev tun0 metric 1

sudo ip route add default via 192.168.43.1 dev enp3s0 metric 10

tun2socks -device tun0 -proxy socks5://127.0.0.1:1081 &

sudo ip route add default via 192.168.43.1 dev enp3s0 metric 1 table 110

sudo ip rule add uidrange 1001-1001 lookup 110 pref 29000

pkexec --user psiphon  ./psiphon-tunnel-core-x86_64  --config psiphone.conf

#In case of Windows 11 OS, use SSTAP Beta + ForceBindIP64 optout for tun2socks

#To persist ICS consult this https://learn.microsoft.com/en-us/troubleshoot/windows-client/networking/ics-not-work-after-computer-or-service-restart

https://github.com/loxia01/PSInternetConnectionSharing 

netsh interface ip reset

for /f "tokens=3 delims=: " %%i  in ('netsh interface ip show config name^="Wi-Fi 3" ^| findstr "IP Address"') do set IP=%%i

D:\Portables\Psiphon3\ForceBindIP64.exe -i %IP% D:\Portables\Psiphon3\psiphon-tunnel-core-x86_64.exe -config D:\Portables\Psiphon3\psiphone.conf




