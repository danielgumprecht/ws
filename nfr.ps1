# Network Firewall Rules
netsh advfirewall firewall set rule group="Remotedesktop" new enable=yes
netsh advfirewall firewall set rule group="Netzwerkerkennung" new enable=yes
netsh advfirewall firewall set rule group="Datei- und Druckerfreigabe" new enable=yess

# The Same in Powershell (slower)
Enable-NetFirewallRule -DisplayGroup "Remotedesktop"
Enable-NetFirewallRule -DisplayGroup "Netzwerkerkennung"
Enable-NetFirewallRule -DisplayGroup "Datei- und Druckerfreigabe"