## nlafix

Dieses Skript konfiguriert die grundlegende Netzwerkunterstützung durch Starten bestimmter Dienste, Aktivieren wichtiger Firewall-Regeln und Einrichten von Abhängigkeiten für den Netzwerkstandort-Dienst.

### Dieses PowerShell Skript macht folgendes:

1.	**Aktivieren und Starten von Diensten:** Eine Liste von Diensten (RpcSs, SSDPSRV, upnphost) wird durchlaufen. Jeder Dienst in der Liste wird so konfiguriert, dass er beim Systemstart automatisch startet, und anschließend wird der Dienst gestartet.
2.	**Firewall-Regeln setzen:** Die Regeln für „Netzwerkerkennung“ und „Datei- und Druckerfreigabe“ in der Windows-Firewall werden aktiviert, um Netzwerkfunktionen und Freigaben zu ermöglichen.
3.	**Festlegen von Abhängigkeiten für den NLA-Dienst:** Der nlasvc (Network Location Awareness Service) wird so konfiguriert, dass er von mehreren anderen Diensten abhängt (NSI, RpcSs, TcpIp, Dhcp, Eventlog, DNS). Dies stellt sicher, dass diese Abhängigkeiten beim Start von NLA verfügbar sind.

### Code

```powershell
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
sc.exe config nlasvc depend= NSI/RpcSs/TcpIp/Eventlog/DNS
````

### Technische Erklärung
- Setzt drei Services auf Automatisch, welche Abhängigkeiten der Netzwerkerkennung sind, und Startet diese im Anschluss in der richtigen Reihenfolge > aktiviert die notwendigen Dienste für die Netzwerkerkennung
- Aktiviert nochmal alle Firewall Rules für die Netzwerkerkennung und die Datei und Druckerfreigabe > stellt sicher dass die Netzwerkerkennung tatsächlich aktiviert ist
- Fügt dem Service Network Location Awareness noch DNS als Abhängigkeit hinzu > sorgt für eine zuverlässigere Netzwerkerkennung, da DNS laufen muss, dass die NLA die richtige Netzwerkumgebung erkennen kann (wenn Network Location falsch ist dann braucht der NLA Service nach diesen Änderungen einen Neustart)

### Das Skript kann man wie folgt auf Servern ausführen:

- PowerShell als Administrator starten und folgendes eingeben:  
- `irm gump.at/nlafix | iex`