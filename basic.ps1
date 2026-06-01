Write-Host "ws.gump.at/basic: Starting basic configuration." -ForegroundColor Red

Write-Host "ws.gump.at/basic: Setting Windows language to de-AT." -ForegroundColor Cyan
Set-WinSystemLocale de-AT
Set-WinUILanguageOverride -Language de-AT
Write-Host "ws.gump.at/basic: Windows language set to de-AT." -ForegroundColor Green

Write-Host "ws.gump.at/basic: Enabling Local Admin and disabling W10 and W11 accounts." -ForegroundColor Cyan
Enable-LocalUser "Administrator"
Disable-LocalUser "W10" -ErrorAction SilentlyContinue
Disable-LocalUser "W11" -ErrorAction SilentlyContinue
Get-LocalUser | Set-LocalUser -PasswordNeverExpires $true
Write-Host "ws.gump.at/basic: Local Admin enabled and W10/W11 accounts disabled." -ForegroundColor Green

Write-Host "ws.gump.at/basic: Disabling IPv6 on all network adapters." -ForegroundColor Cyan
Disable-NetAdapterBinding -Name * -ComponentID "ms_tcpip6"
Write-Host "ws.gump.at/basic: IPv6 disabled on all network adapters." -ForegroundColor Green

Write-Host "ws.gump.at/basic: Setting Network Location Awareness (NLA) service to Delayed Start." -ForegroundColor Cyan
sc.exe config NlaSvc start=delayed-auto
Write-Host "ws.gump.at/basic: NLA service set to Delayed Start." -ForegroundColor Green

Write-Host "ws.gump.at/basic: Enabling Firewall rules for Remote Desktop, Network Discovery, and File and Printer Sharing." -ForegroundColor Cyan
Enable-NetFirewallRule -DisplayGroup "Remotedesktop"
Enable-NetFirewallRule -DisplayGroup "Netzwerkerkennung"
Enable-NetFirewallRule -DisplayGroup "Datei- und Druckerfreigabe"
Write-Host "ws.gump.at/basic: Firewall rules enabled for Remote Desktop, Network Discovery, and File and Printer Sharing." -ForegroundColor Green

Write-Host "ws.gump.at/basic: Adding 'Jeder' to Remote Desktop Users group." -ForegroundColor Cyan
Add-LocalGroupMember -Group "Remotedesktopbenutzer" -Member "Jeder" -ErrorAction SilentlyContinue
Write-Host "ws.gump.at/basic: 'Jeder' added to Remote Desktop Users group." -ForegroundColor Green

Write-Host "ws.gump.at/basic: Privacy adjustments: Disabling telemetry, search suggestions, and widgets." -ForegroundColor Cyan
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Force -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DisableOneSettingsDownloads" -Value 1 -Force -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Value 1 -Force -ErrorAction SilentlyContinue
Write-Host "ws.gump.at/basic: Privacy adjustments completed." -ForegroundColor Green

Write-Host "ws.gump.at/basic: Adjusting search settings." -ForegroundColor Cyan
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCloudSearch" -Value 0 -Force -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Value 0 -Force -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortanaAboveLock" -Value 0 -Force -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowSearchToUseLocation" -Value 0 -Force -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "ConnectedSearchUseWeb" -Value 0 -Force -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "DisableWebSearch" -Value 1 -Force -ErrorAction SilentlyContinue
Write-Host "ws.gump.at/basic: Search settings adjusted." -ForegroundColor Green

Write-Host "ws.gump.at/basic: Adjusting Explorer settings." -ForegroundColor Cyan
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value 1 -Force -ErrorAction SilentlyContinue
Write-Host "ws.gump.at/basic: Explorer settings adjusted." -ForegroundColor Green

Write-Host "ws.gump.at/basic: Adjusting Remote Desktop settings." -ForegroundColor Cyan
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "UserAuthentication" -Value 0
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "SecurityLayer" -Value 1
Write-Host "ws.gump.at/basic: Remote Desktop settings adjusted." -ForegroundColor Green

Write-Host "ws.gump.at/basic: Adjusting Widgets settings." -ForegroundColor Cyan
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Name "AllowNewsAndInterests" -Value 0 -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests" -Name "value" -Value 1
Write-Host "ws.gump.at/basic: Widgets settings adjusted." -ForegroundColor Green

Write-Host "ws.gump.at/basic: Disabling hibernation and fast startup." -ForegroundColor Cyan
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 0
Write-Host "ws.gump.at/basic: Hibernation and fast startup disabled." -ForegroundColor Green

Write-Host "ws.gump.at/basic: Adjusting power button and lock screen settings." -ForegroundColor Cyan
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "DisableLogonBackgroundImage" -Value 1 -Force -ErrorAction SilentlyContinue
Write-Host "ws.gump.at/basic: Power button and lock screen settings adjusted." -ForegroundColor Green

Write-Host "ws.gump.at/basic: Disabling lock screen." -ForegroundColor Cyan
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name "NoLockScreen" -Value 1 -Force -ErrorAction SilentlyContinue
Write-Host "ws.gump.at/basic: Lock screen disabled." -ForegroundColor Green

Write-Host "ws.gump.at/basic: Setting power button action to shutdown." -ForegroundColor Cyan
powercfg /setacvalueindex SCHEME_CURRENT SUB_BUTTONS PBUTTONACTION 3
powercfg /setdcvalueindex SCHEME_CURRENT SUB_BUTTONS PBUTTONACTION 3
Write-Host "ws.gump.at/basic: Power button action set to shutdown." -ForegroundColor Green

Stop-Process -Name "Explorer" -Force
