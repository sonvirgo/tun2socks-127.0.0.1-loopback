@echo off
c:
cd  C:\Tools\Psiphon3

:FOUND0

netsh interface show interface|find "Connected"|find "Wi-Fi 2"

if errorlevel 1 (
    
   echo Wifi not found

   TIMEOUT /T 1	

   goto FOUND0

)  

for /f "tokens=3 delims=: " %%i in ('netsh interface ip show config name^="Wi-Fi 2" ^| findstr "IP Address"') do set IP=%%i

c:\tools\Psiphon3\ForceBindIP64.exe -i %IP% c:\tools\Psiphon3\psiphon-tunnel-core-x86_64.exe -config c:\tools\Psiphon3\psiphone.conf

:FOUND1

netstat -ano | find "1081" | find "LISTEN"

if errorlevel 1 (
    
   echo port not found

   TIMEOUT /T 1	

   goto FOUND1

)  

rem cd C:\Users\virgosun\AppData\Local\SSTap-beta

rem start "" C:\Users\virgosun\AppData\Local\SSTap-beta\SSTap.exe

rem  :FOUND2

rem  netsh interface show interface|find "Connected"|find "SSTAP 1"

rem  if errorlevel 1 (
    
rem    echo SSTap not found

rem    TIMEOUT /T 1	

rem    goto FOUND2

rem  )

start ""   tun2socks-windows-amd64 -device tun://wintun?guid={7FE5A4A1-1326-40E2-974C-EF617156ACA8} -proxy socks5://127.0.0.1:1081

:FOUND3

netsh interface show interface|find "Connected"|find "wintun"

if errorlevel 1 (
    
  echo wintun not found

  TIMEOUT /T 1	

  goto FOUND3

)

netsh interface ip set address name="wintun" source=static addr=192.168.123.1 mask=255.255.255.0 gateway=none

rem netsh interface ipv4 set interface wintun metric=6 

rem netsh int ipv4 add route 0.0.0.0/0 wintun 192.168.123.1   

for /f "tokens=*" %%i in ('netsh int ipv4 show interfaces ^| find "wintun"') do set str=%%i

set /A num=str

route delete 0.0.0.0 mask 0.0.0.0 192.168.123.1 

route add 0.0.0.0 mask 0.0.0.0 192.168.123.1 IF %num% metric 5

C:\tools\htpdate\htpdate.exe  -s -C "[time ]HH:mm:ss.SS[ && date ]MM-DD-YY" -p http google.com

powershell -Command "Disable-Ics"

TIMEOUT /T 1	

powershell -Command "Set-Ics wintun Ethernet"

rem C:\Tools\PersistentHotspot\PersistentHotspot.exe

rem netsh wlan start hostednetwork