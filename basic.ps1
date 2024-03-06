# Set Windows Lanugage to de-AT
Set-WinSystemLocale de-AT
Set-WinUILanguageOverride -Language de-AT

# Enable Local Admin and disable W10 and W11
Enable-LocalUser "Administrator"
Disable-LocalUser "W10" -ErrorAction SilentlyContinue
Disable-LocalUser "W11" -ErrorAction SilentlyContinue
Get-LocalUser | Set-LocalUser -PasswordNeverExpires $true

# Disable IPv6
Disable-NetAdapterBinding -Name * -ComponentID "ms_tcpip6"

# Network Location Awareness to Delayed
sc.exe config NlaSvc start=delayed-auto

# Enable Firewall Rules
netsh advfirewall firewall set rule group="Remotedesktop" new enable=yes
netsh advfirewall firewall set rule group="Netzwerkerkennung" new enable=yes
netsh advfirewall firewall set rule group="Datei- und Druckerfreigabe" new enable=yess

# Add Any to Remotedesktopbenutzer
Add-LocalGroupMember -Group "Remotedesktopbenutzer" -Member "Jeder" -ErrorAction SilentlyContinue

# Search Adjustments
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value 1 -Force
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Value 0 -Force

# RDP
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "UserAuthentication" -Value 0
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "SecurityLayer" -Value 1

# Hiberboot Off
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 0

# Lockscreen Adjustments
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name "NoLockScreen" -Value 1
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "DisableLogonBackgroundImage" -Value 1

# Set Powerbutton to Shutdown
powercfg /setacvalueindex SCHEME_CURRENT SUB_BUTTONS PBUTTONACTION 3
powercfg /setdcvalueindex SCHEME_CURRENT SUB_BUTTONS PBUTTONACTION 3

# Restart Explorer
Stop-Process -Name "Explorer" -Force
