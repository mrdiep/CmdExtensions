call CmdExtensions.exe GetIniConfig -FilePath:"config.ini" -Key:vpn-cli > temp.txt
set /p VPN_CLI=<temp.txt

call %VPN_CLI% disconnect