Install-WindowsFeature Search-Service
Install-WindowsFeature Telnet-Client
Install-WindowsFeature TFTP-Client
Add-WindowsFeature Windows-Server-Backup -IncludeManagementTools -Restart
Enable-WindowsOptionalFeature -Online -FeatureName "NetFx3" -All
n

Enable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol" -All
n

Uninstall-WindowsFeature -Name Windows-Defender

New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters" -Name "AlwaysExpectDomainController" -Value 1 -Type DWORD

shutdown /r /t 0
