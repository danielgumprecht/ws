---
title: Script Documentation - rmm.ps1
layout: default
tags:
  - PowerShell
  - Windows
---
## Remote Monitoring & Management - Removal Skript

### Ausführen
1. Windows + X auf der Tastatur drücken, es öffnet sich an der Taskleiste ein schwarzes Fenster mit mehreren Shortcuts zu diversen Einstellungen
2. Danach auf `PowerShell (Administrator)` klicken
3. `irm gump.at/rmm | iex` eingeben - Enter
4. Dieses Skript prüft ob CWA installiert ist, und löscht danach das Remote Monitoring und alle damit verbundenen Services

### Changelog
- 30.03.2024 - Erstellung des Skripts
- 18.04.2024 - Services ergänzt
- 19.04.2024 - Fehlerbehebungen 
- 04.11.2024 -  Services ergänzt

### Detail
1. **Überprüfung des CWA-Dienstes:** Das Skript prüft, ob der Dienst “LTService” (CWA Service) auf dem System vorhanden ist.
2.	**Bestätigung und Start:** Wenn der Dienst vorhanden ist, gibt das Skript eine Meldung aus und beginnt mit der Ausführung der nächsten Schritte.
3.	**Beenden von N-Able-Prozessen:** Eine Liste von N-Able-bezogenen Prozessen (z. B. “PME.Agent”, “FileCacheServiceAgent”, “winagent”) wird durchgegangen, und jeder gefundene Prozess wird beendet.
4.	**Deaktivierung von N-Able-Diensten:** Eine weitere Liste von Diensten, die mit N-Able in Verbindung stehen, wird durchlaufen und auf den Starttyp “Deaktiviert” gesetzt.
5.	**Löschen von N-Able-Installationsverzeichnissen:** Das Skript entfernt alle relevanten Installationspfade von N-Able und verwandten Programmen. Dies erfolgt rekursiv und gewaltsam, um alle Dateien in diesen Verzeichnissen zu löschen.
6.	**Überprüfung der verbleibenden Pfade:** Nachdem die Verzeichnisse gelöscht wurden, überprüft das Skript, ob diese Pfade weiterhin existieren. Falls ein Pfad noch vorhanden ist, gibt das Skript eine Nachricht aus, dass ein Neustart und eine erneute Ausführung des Skripts erforderlich sind, um die Löschung abzuschließen.
7.	**Abbruch bei fehlendem CWA-Dienst:** Wenn der CWA-Dienst “LTService” nicht auf dem System gefunden wird, gibt das Skript eine Meldung aus und beendet die Ausführung.

### Code
```powershell
# Check if CWA service exists
if (Get-Service -Name "LTService" -ErrorAction SilentlyContinue) {

    Write-Host "CWA service exists. Launching script..."

    # kill N-Able tasks
    $tasks = @(
        "PME.Agent",
        "FileCacheServiceAgent",
        "RequestHandlerAgent",
        "EcosystemAgent",
        "EcosystemAgentMaintenance",
        "ASupSrvc",
        "BASupSrvc",
        "BASupSrvcCnfg",
        "BASupSrvcUpdater",
        "Au_",
        "winagent",
        "WebProtection",
        "TCLauncherHelper",
        "TakeControlRDLdr",
        "TakeControlRDViewer",
        "SolarWinds.MSP.Ecosystem.WindowsAgent",
        "SolarWinds.MSP.Ecosystem.WindowsAgentMaint"
    )

    foreach ($task in $tasks) {
    Get-Process -Name $task -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
    }

    # disable N-Able services
    $services = @(
        "PME.Agent.PmeService",
        "SolarWinds.MSP.CacheService",
        "SolarWinds.MSP.RpcServerService",
        "SolarWinds.MSP.Ecosystem.WindowsAgent",
        "SolarWinds.MSP.Ecosystem.WindowsAgentMaint",
        "BASupportExpressStandaloneService_LOGICnow",
        "BASupportExpressSrvcUpdater_LOGICnow",
        "Advanced Monitoring Agent",
        "EcosystemAgent",
        "EcosystemAgentMaintenance",
        "WebProtection"
    )

    foreach ($service in $services) {
    Set-Service -Name $service -StartupType Disabled -ErrorAction SilentlyContinue
    }

    # Remove N-able install locations, also removes them from services.msc
    Remove-Item "C:\Program Files\Advanced Monitoring Agent Web Protection\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\Program Files (x86)\Advanced Monitoring Agent GP\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\Program Files (x86)\Advanced Monitoring Agent\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\Program Files (x86)\Take Control Agent\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\Program Files (x86)\BeAnywhere Support Express\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\Program Files (x86)\N-Able Technologies\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\Program Files (x86)\SolarWinds MSP\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\ProgramData\AdvancedMonitoringAgentWebProtection\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\ProgramData\GetSupportService_Common_LOGICnow\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\ProgramData\GetSupportService_Common\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\ProgramData\GetSupportService_LOGICnow\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\ProgramData\GetSupportService\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\ProgramData\MspPlatform\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\ProgramData\MSPEcosystem\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\ProgramData\SolarWinds MSP\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\ProgramData\N-able\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\ProgramData\N-Able Technologies\" -recurse -force -ErrorAction SilentlyContinue

# Check if Paths still exist
$paths = @("C:\Program Files\Advanced Monitoring Agent Web Protection\",
"C:\Program Files (x86)\Advanced Monitoring Agent GP\",
"C:\Program Files (x86)\Advanced Monitoring Agent\",
"C:\Program Files (x86)\Take Control Agent\",
"C:\Program Files (x86)\BeAnywhere Support Express\",
"C:\Program Files (x86)\N-Able Technologies\",
"C:\ProgramData\AdvancedMonitoringAgentWebProtection\",
"C:\ProgramData\GetSupportService_Common_LOGICnow\",
"C:\ProgramData\GetSupportService_Common\",
"C:\ProgramData\GetSupportService_LOGICnow\",
"C:\ProgramData\GetSupportService\",
"C:\ProgramData\MspPlatform\",
"C:\ProgramData\MSPEcosystem\",
"C:\ProgramData\SolarWinds MSP\",
"C:\ProgramData\N-able\",
"C:\ProgramData\N-Able Technologies\"
)

foreach ($path in $paths) {
    if (Test-Path $path) {
        Write-Host "Path $path still exists. Reboot and relaunch the script to finish deletion"
    } else {}
}

} else {

Write-Host "CWA not found. Stopping Script."

}
```