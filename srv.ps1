Uninstall-WindowsFeature -Name Windows-Defender

Disable-ScheduledTask -TaskPath "\Microsoft\Windows\Server Manager" -TaskName "ServerManager" -ErrorAction SilentlyContinue

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value 0

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Install-WindowsFeature DHCP -IncludeManagementTools
Install-WindowsFeature DNS -IncludeManagementTools
Install-WindowsFeature Print-Server -IncludeManagementTools
Install-WindowsFeature Web-Mgmt-Console -IncludeManagementTools
Install-WindowsFeature Search-Service
Install-WindowsFeature TFTP-Client
Add-WindowsFeature Windows-Server-Backup -IncludeManagementTools -Restart
Enable-WindowsOptionalFeature -Online -FeatureName "NetFx3" -All
Enable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol" -All
sc.exe config nlasvc depend= NSI/RpcSs/TcpIp/Dhcp/Eventlog/DNS
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters" -Name "AlwaysExpectDomainController" -Value 1 -Type DWORD
