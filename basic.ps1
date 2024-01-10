
Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe

Set-WinSystemLocale de-AT
Set-WinUILanguageOverride -Language de-AT
Set-WinUserLanguageList de-AT -Force

Enable-LocalUser "Administrator"
Disable-LocalUser "W10"
Disable-LocalUser "W11"

Disable-NetAdapterBinding -Name * -ComponentID "ms_tcpip6"
sc.exe config NlaSvc start=delayed-auto

Enable-NetFirewallRule -DisplayGroup "Remotedesktop"
net localgroup "Remotedesktopbenutzer" "Jeder" /add
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0 -Type DWORD
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "UserAuthentication" -Value 0 -Type DWORD
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "SecurityLayer" -Value 1 -Type DWORD

netsh advfirewall firewall set rule group="Netzwerkerkennung" new enable=Yes
netsh advfirewall firewall set rule group="Datei- und Druckerfreigabe" new enable=Yes

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value 0 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value 0 -Force

if( -not (Test-Path -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization")){
    New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
    }
    
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name "NoLockScreen" -Value 1 -Type DWORD

if( -not (Test-Path -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer")){
    New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
    }
    
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value 1 -Type DWORD
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 0 -Type DWORD
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 -Type DWORD

New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Value "" -Force
