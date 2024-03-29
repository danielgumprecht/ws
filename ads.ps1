# Active Directory Server Setup
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Install-WindowsFeature DHCP -IncludeManagementTools
Install-WindowsFeature DNS -IncludeManagementTools
Install-WindowsFeature Print-Server -IncludeManagementTools
Install-WindowsFeature Web-Mgmt-Console -IncludeManagementTools
Install-WindowsFeature Search-Service
Install-WindowsFeature TFTP-Client
Add-WindowsFeature Windows-Server-Backup -IncludeManagementTools -Restart
Enable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol" -All
sc.exe config nlasvc depend= NSI/RpcSs/TcpIp/Dhcp/Eventlog/DNS
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters" -Name "AlwaysExpectDomainController" -Value 1 -Type DWORD