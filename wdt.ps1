
Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe

Enable-LocalUser "Administrator"
Disable-LocalUser "W10"
Disable-LocalUser "W11"

Enable-NetFirewallRule -DisplayGroup "Remotedesktop"

netsh advfirewall firewall set rule group="Netzwerkerkennung" new enable=Yes
netsh advfirewall firewall set rule group="Datei- und Druckerfreigabe" new enable=Yes
net localgroup "Remotedesktopbenutzer" "Jeder" /add
powercfg /setacvalueindex SCHEME_CURRENT SUB_BUTTONS PBUTTONACTION 3
powercfg /setdcvalueindex SCHEME_CURRENT SUB_BUTTONS PBUTTONACTION 3
powercfg /setacvalueindex SCHEME_CURRENT SUB_BUTTONS LIDACTION 0
powercfg /setdcvalueindex SCHEME_CURRENT SUB_BUTTONS LIDACTION 0

powercfg /hibernate off
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 0
powercfg /change disk-timeout-ac 0
powercfg /change disk-timeout-dc 0
powercfg /change hibernate-timeout-ac 0
powercfg /change hibernate-timeout-dc 0
powercfg /change monitor-timeout-ac 0
powercfg /change monitor-timeout-dc 0

if( -not (Test-Path -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization")){
    New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
    }
    
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name "NoLockScreen" -Value 1 -Type DWORD

if( -not (Test-Path -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer")){
    New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
    }
    
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value 1 -Type DWORD
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 0 -Type DWORD
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0 -Type DWORD
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "SecurityLayer" -Value 0 -Type DWORD
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "UserAuthentication" -Value 0 -Type DWORD
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 -Type DWORD


New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Value "" -Force

winget install -e --silent --accept-source-agreements --accept-package-agreements --id "7zip.7zip"
winget install -e --silent --accept-source-agreements --accept-package-agreements --id "Google.Chrome"
winget install -e --silent --accept-source-agreements --accept-package-agreements --id "mozilla.firefox"
winget install -e --silent --accept-source-agreements --accept-package-agreements --id "Adobe.Acrobat.Reader.64-bit"
winget install -e --silent --accept-source-agreements --accept-package-agreements --id "pdfforge.PDFCreator" 
Start-BitsTransfer -Source "https://customdesignservice.teamviewer.com/download/windows/v15/m4pd3bk/TeamViewerQS.exe" -Destination "C:\Users\Public\Desktop"

Enable-WindowsOptionalFeature -Online -FeatureName "NetFx3"

Stop-Process -processName: Explorer -force
