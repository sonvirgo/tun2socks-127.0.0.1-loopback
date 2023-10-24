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

cd C:\Users\virgosun\AppData\Local\SSTap-beta

start "" C:\Users\virgosun\AppData\Local\SSTap-beta\SSTap.exe

:FOUND2

netsh interface show interface|find "Connected"|find "SSTAP 1"

if errorlevel 1 (
    
   echo SSTap not found

   TIMEOUT /T 1	

   goto FOUND2

)  

C:\Portables\htpdate\htpdate.exe  -s -C "[time ]HH:mm:ss.SS[ && date ]MM-DD-YY" -p http google.com

rem C:\Tools\PersistentHotspot\PersistentHotspot.exe

netsh wlan start hostednetwork