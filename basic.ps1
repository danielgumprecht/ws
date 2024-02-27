Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe

Set-WinSystemLocale de-AT
Set-WinUILanguageOverride -Language de-AT
Set-WinUserLanguageList de-AT -Force

Enable-LocalUser "Administrator"
Disable-LocalUser "W10" -ErrorAction SilentlyContinue
Disable-LocalUser "W11" -ErrorAction SilentlyContinue

Disable-ScheduledTask -TaskPath "\Microsoft\Windows\Server Manager" -TaskName "ServerManager" -ErrorAction SilentlyContinue

Disable-NetAdapterBinding -Name * -ComponentID "ms_tcpip6"
netsh int tcp set global timestamps=disabled

sc.exe config NlaSvc start=delayed-auto

Enable-NetFirewallRule -DisplayGroup "Remotedesktop"
Enable-NetFirewallRule -DisplayGroup "Netzwerkerkennung"
Enable-NetFirewallRule -DisplayGroup "Datei- und Druckerfreigabe"

Add-LocalGroupMember -Group "Remotedesktopbenutzer" -Member "Jeder" -ErrorAction SilentlyContinue

# Alte TLS Versionen Deaktivieren
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" -Name "Enabled" -Value 0 -Force -Type DWORD -ErrorAction SilentlyContinue
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" -Name "Enabled" -Value 0 -Force -Type DWORD -ErrorAction SilentlyContinue
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" -Name "DisabledByDefault" -Value 1 -Force -Type DWORD -ErrorAction SilentlyContinue
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" -Name "DisabledByDefault" -Value 1 -Force -Type DWORD -ErrorAction SilentlyContinue

# RDP Aktivieren
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0 -Force -Type DWORD -ErrorAction SilentlyContinue
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "UserAuthentication" -Value 0 -Force -Type DWORD -ErrorAction SilentlyContinue
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "SecurityLayer" -Value 0 -Force -Type DWORD -ErrorAction SilentlyContinue

# Internet Explorer Erweiterte Sicherheit deaktivieren
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value 0 -Force -Type DWORD -ErrorAction SilentlyContinue
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value 0 -Force -Type DWORD -ErrorAction SilentlyContinue

# Weitere Personalisierungen 
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value 1 -Force -Type DWORD -ErrorAction SilentlyContinue
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 0 -Force -Type DWORD -ErrorAction SilentlyContinue
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name "NoLockScreen" -Value 1 -Force -Type DWORD -ErrorAction SilentlyContinue

# Lokaler User Sachen
New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value 1 -Force -Type DWORD -ErrorAction SilentlyContinue
New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 -Force -Type DWORD -ErrorAction SilentlyContinue
New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "AllowCortana" -Value 0 -Force -Type DWORD -ErrorAction SilentlyContinue
New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 0 -Force -Type DWORD -ErrorAction SilentlyContinue
New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "AllowSearchToUseLocation" -Value 0 -Force -Type DWORD -ErrorAction SilentlyContinue
New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0 -Force -Type DWORD -ErrorAction SilentlyContinue
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0 -Force -Type DWORD -ErrorAction SilentlyContinue
New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Value "" -Force -Type DWORD -ErrorAction SilentlyContinue
New-Item -Path "HKCU:\Control Panel\Mouse\" -Name "MouseSpeed" -Value 0 -Force -Type DWORD -ErrorAction SilentlyContinue

Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force

Stop-Process -Name "Explorer" -Force
