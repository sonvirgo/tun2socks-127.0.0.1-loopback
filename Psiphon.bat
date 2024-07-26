@echo off
d:
cd  d:\progs\VPN

:FOUND0

netsh interface show interface|find "Connected"|find "Ethernet"

if errorlevel 1 (
    
   echo Wifi/Ethenet not connected

   TIMEOUT /T 1	

   goto FOUND0

)  

rem netsh int ipv4 add route 125.235.36.0/24 "Ethernet" 192.168.1.250

for /f "tokens=*" %%i in ('netsh int ipv4 show interfaces ^| find "Ethernet"') do set str=%%i

set /A num2=str

route add 125.235.0.0 MASK 255.255.0.0 192.168.1.250 IF %num2% metric 4

rem route add 8.219.113.0 mask 255.255.255.0 192.168.1.250 IF %num2% metric 4

rem route add 171.244.232.0 mask 255.255.255.0 192.168.1.250 IF %num2% metric 4

rem route add 203.190.171.0 mask 255.255.255.0 192.168.1.250 IF %num2% metric 4

rem route add 172.66.43.0 mask 255.255.255.0 192.168.1.1 IF %num2% metric 4

rem route add 104.26.14.0 mask 255.255.255.0 192.168.1.1 IF %num2% metric 4

rem route add 104.26.15.0 mask 255.255.255.0 192.168.1.1 IF %num2% metric 4

rem route add 172.67.74.0 mask 255.255.255.0 192.168.1.1 IF %num2% metric 4

for /f "tokens=3 delims=: " %%i in ('netsh interface ip show config name^="Ethernet" ^| findstr "IP Address"') do set IP=%%i

rem d:\progs\VPN\ForceBindIP64.exe -i %IP% 

start /B d:\progs\VPN\go-dispatch-proxy.exe -lport 1080  %IP% 

start /B  d:\progs\VPN\MTOS5.exe 

start /B d:\progs\VPN\psiphon-tunnel-core-x86_64.exe -config d:\progs\VPN\psiphone.conf -serverList d:\progs\VPN\psiphon-embedded-server-entries.txt

:FOUND1

netstat -ano | find "2088" | find "LISTEN"

if errorlevel 1 (
    
   echo port not found

   TIMEOUT /T 1	

   goto FOUND1

)  

start /B  tun2socks-windows-amd64 -device tun://wintun?guid={7FE5A4A1-1326-40E2-974C-EF617156ACA8} -proxy socks5://127.0.0.1:3080 -interface "Ethernet"

:FOUND3

netsh interface show interface|find "Connected"|find "wintun"

if errorlevel 1 (
    
   echo wintun not found

   TIMEOUT /T 1	

   goto FOUND3

)

netsh interface ip set address name="wintun" source=static addr=192.168.123.1 mask=255.255.255.0 gateway=none

netsh interface ipv4 set interface wintun metric=6 

rem start /B  d:\progs\VPN\dispatch.exe start --port 3080  %IP%@7 192.168.123.1@3

rem cd C:\Users\virgosun\AppData\Local\SSTap-beta

rem start "" C:\Users\virgosun\AppData\Local\SSTap-beta\SSTap.exe

rem :FOUND2

rem netsh interface show interface|find "Connected"|find "SSTAP 1"

rem if errorlevel 1 (
    
rem echo SSTap not found

rem TIMEOUT /T 1	

rem goto FOUND2

rem )

rem netsh int ipv4 add route 0.0.0.0/0 wintun 192.168.123.1   

for /f "tokens=*" %%i in ('netsh int ipv4 show interfaces ^| find "wintun"') do set str=%%i

set /A num=str

route add 0.0.0.0 mask 0.0.0.0 192.168.123.1 IF %num% metric 5

cd  d:\progs\VPN

TIMEOUT /T 10	

htpdate-x64.exe  -s -C "[time ]HH:mm:ss.SS[ && date ]MM-DD-YY" -p http http://1.1.1.1

rem rempowershell -Command "Disable-Ics"

rem TIMEOUT /T 1	

rem powershell -Command "Set-Ics wintun Ethernet 2"

rem C:\Tools\PersistentHotspot\PersistentHotspot.exe

rem netsh wlan start hostednetwork