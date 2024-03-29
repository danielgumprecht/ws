# Uninstall Windows Defender
Uninstall-WindowsFeature -Name Windows-Defender

# Disable Server Manager Autostart
Disable-ScheduledTask -TaskPath "\Microsoft\Windows\Server Manager" -TaskName "ServerManager" -ErrorAction SilentlyContinue

# Disable Internet Explorer Security Policies
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value 0

# Enable NetFX3
Enable-WindowsOptionalFeature -Online -FeatureName "NetFx3" -All