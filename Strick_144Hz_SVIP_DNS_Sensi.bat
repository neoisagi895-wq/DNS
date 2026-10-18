@echo off
fltmc >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

powershell -WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -Command "$adapters = Get-NetAdapter | Where-Object {$_.Status -eq 'Up'}; foreach ($a in $adapters) { Set-DnsClientServerAddress -InterfaceIndex $a.ifIndex -ServerAddresses ('9.9.9.9','149.112.112.112','2620:fe::fe','2620:fe::9') }; Clear-DnsClientCache; ipconfig /flushdns"