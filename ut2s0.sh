#!/usr/bin/env bash
cd ~
#while ! /Sy*/L*/Priv*/Apple8*/V*/C*/R*/airport -I | awk '/ SSID:/ {print $2}' | grep 'Code.gurus' > /dev/null  ;
#do
#  sleep 1
#  #printf 'wifi not connected ... try connecintg ...'
#  networksetup -setairportnetwork en1 Code.gurus 12345678
#done
pass=1234
{
#exp
echo $pass | sudo -S route delete  -net 125.235.36.0/24 192.168.1.250
# nohup ./psiphon-tunnel-core-x86_64 --config psiphone.conf > /dev/null 2>&1&
#end exp


echo $pass | sudo -S killall  psiphon-tunnel-core-x86_64
echo $pass | sudo -S killall  tun2socks-darwin-amd64
echo $pass | sudo -S killall  go-dispatch-proxy
echo $pass | sudo -S killall  MTOSocks5-x86_64


# nohup echo $pass | sudo -S  ./tun2socks-darwin-amd64  -device utun123 -proxy socks5://127.0.0.1:2088 -interface en0  > /dev/null 2>&1&
sleep 5
# echo $pass | sudo -S ifconfig utun123 198.18.0.1 198.18.0.1 up
echo $pass | sudo -S route delete  -net 1.0.0.0/8 198.18.0.1
echo $pass | sudo -S route delete  -net 2.0.0.0/7 198.18.0.1
echo $pass | sudo -S route delete  -net 4.0.0.0/6 198.18.0.1
echo $pass | sudo -S route delete -net 8.0.0.0/5 198.18.0.1
echo $pass | sudo -S route delete -net 16.0.0.0/4 198.18.0.1
echo $pass | sudo -S route delete -net 32.0.0.0/3 198.18.0.1
echo $pass | sudo -S route delete -net 64.0.0.0/2 198.18.0.1
echo $pass | sudo -S route delete -net 128.0.0.0/1 198.18.0.1
echo $pass | sudo -S route delete  -net 198.18.0.0/15 198.18.0.1
# echo $pass  | sudo -S ./htpdate-mac-x64  -s -C  '[date  ]MMDDHHmmYY'  http://142.250.105.139
}

