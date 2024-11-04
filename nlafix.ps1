# nlafix

# enable and start Services
$services = @(
    "RpcSs",
    "SSDPSRV",
    "upnphost"
)

foreach ($service in $services) {
Set-Service -Name $service -StartupType Automatic -ErrorAction SilentlyContinue
Start-Service -Name $service
}

# set Firewall Rules
Enable-NetFirewallRule -DisplayGroup "Remotedesktop"
Enable-NetFirewallRule -DisplayGroup "Netzwerkerkennung"
Enable-NetFirewallRule -DisplayGroup "Datei- und Druckerfreigabe"

#set Dependencies for NLA
sc.exe config nlasvc depend= NSI/RpcSs/TcpIp/Dhcp/Eventlog/DNS
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters" -Name "AlwaysExpectDomainController" -Value 1 -Type DWORD

# Disable IPv6
Disable-NetAdapterBinding -Name * -ComponentID "ms_tcpip6"