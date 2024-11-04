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
Enable-NetFirewallRule -DisplayGroup "Netzwerkerkennung"
Enable-NetFirewallRule -DisplayGroup "Datei- und Druckerfreigabe"

# set Dependencies for NLA
sc.exe config nlasvc depend= NSI/RpcSs/TcpIp/Dhcp/Eventlog/DNS

# Disable IPv6
Disable-NetAdapterBinding -Name * -ComponentID "ms_tcpip6"
