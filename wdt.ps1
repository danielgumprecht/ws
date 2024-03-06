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
Enable-NetFirewallRule -DisplayGroup "Remotedesktop"
Enable-NetFirewallRule -DisplayGroup "Netzwerkerkennung"
Enable-NetFirewallRule -DisplayGroup "Datei- und Druckerfreigabe"

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

# Enable High Performance Power Plan
powercfg /setacvalueindex SCHEME_CURRENT SUB_BUTTONS PBUTTONACTION 3
powercfg /setdcvalueindex SCHEME_CURRENT SUB_BUTTONS PBUTTONACTION 3
powercfg /setacvalueindex SCHEME_CURRENT SUB_BUTTONS LIDACTION 0
powercfg /setdcvalueindex SCHEME_CURRENT SUB_BUTTONS LIDACTION 0
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 0
powercfg /change disk-timeout-ac 0
powercfg /change disk-timeout-dc 0
powercfg /change hibernate-timeout-ac 0
powercfg /change hibernate-timeout-dc 0
powercfg /change monitor-timeout-ac 0
powercfg /change monitor-timeout-dc 0

# Install basic Programs
winget install -e --silent --accept-source-agreements --accept-package-agreements --id "7zip.7zip"
winget install -e --silent --accept-source-agreements --accept-package-agreements --id "Google.Chrome"
winget install -e --silent --accept-source-agreements --accept-package-agreements --id "Mozilla.Firefox"
winget install -e --silent --accept-source-agreements --accept-package-agreements --id "Adobe.Acrobat.Reader.64-bit"
winget install -e --silent --accept-source-agreements --accept-package-agreements --id "pdfforge.PDFCreator" 
winget install -e --silent --accept-source-agreements --accept-package-agreements --id "VideoLAN.VLC" 
winget install -e --silent --accept-source-agreements --accept-package-agreements --id "AdoptOpenJDK.OpenJDK.8" 
winget install -e --silent --accept-source-agreements --accept-package-agreements --id "AdoptOpenJDK.OpenJDK.11" 
winget install -e --silent --accept-source-agreements --accept-package-agreements --id "Fortinet.FortiClientVPN" 

# TeamViewerQS to Public Desktop
Start-BitsTransfer -Source "https://customdesignservice.teamviewer.com/download/windows/v15/m4pd3bk/TeamViewerQS.exe" -Destination "C:\Users\Public\Desktop"

# Enable NetFX 3
Enable-WindowsOptionalFeature -Online -FeatureName "NetFx3"

# Restart Explorer
Stop-Process -Name "Explorer" -Force
