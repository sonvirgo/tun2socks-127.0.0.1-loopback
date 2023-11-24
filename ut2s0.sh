#!/usr/bin/env bash
#/Sy*/L*/Priv*/Apple8*/V*/C*/R*/airport -I | awk '/ SSID:/ {print $2}' | grep 'Code.Gurus' > /dev/null && {
#cd  /Applications/t2s
pass=1234
#nohup echo $pass | sudo -S  ./tun2socks-darwin-amd64  -device utun123 -proxy socks5://192.168.43.1:2088 -interface en0  > /dev/null 2>&1&
#sleep 10
#echo $pass | sudo -S ifconfig utun123 198.18.0.1 198.18.0.1 up
echo $pass | sudo -S route delete -net 1.0.0.0/8 198.18.0.1
echo $pass | sudo -S route delete -net 2.0.0.0/7 198.18.0.1
echo $pass | sudo -S route delete -net 4.0.0.0/6 198.18.0.1
echo $pass | sudo -S route delete -net 8.0.0.0/5 198.18.0.1
echo $pass | sudo -S route delete -net 16.0.0.0/4 198.18.0.1
echo $pass | sudo -S route delete -net 32.0.0.0/3 198.18.0.1
echo $pass | sudo -S route delete -net 64.0.0.0/2 198.18.0.1
echo $pass | sudo -S route delete -net 128.0.0.0/1 198.18.0.1
echo $pass | sudo -S route delete -net 198.18.0.0/15 198.18.0.1
