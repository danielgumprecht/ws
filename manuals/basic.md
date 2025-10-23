### Hier ist eine detaillierte Erklärung zu jedem Schritt des Skripts:

1. **Set Windows Language to de-AT**: setzt die Systemsprache und die Benutzeroberflächensprache auf Deutsch (Österreich).
2. **Enable Local Admin and disable W10 and W11**: aktiviert das eingebaute Administratorkonto, deaktiviert die Benutzerkonten „W10“ und „W11“, falls vorhanden, und setzt bei allen Usern `PasswordNeverExpires` auf true
3. **Disable IPv6**: `Disable-NetAdapterBinding -Name * -ComponentID "ms_tcpip6"` deaktiviert IPv6 auf allen Netzwerkschnittstellen.
4. **Network Location Awareness to Delayed**: `sc.exe config NlaSvc start=delayed-auto` setzt den Dienst für die Netzwerkortung auf „verzögerter Start“, um eine falsche Location zu verhindern.
5. **Enable Firewall Rules**: Aktiviert Firewall-Regeln für Remotedesktop, Netzwerkfreigabe und Datei-/Druckerfreigabe.
6. **Add Any to Remotedesktopbenutzer**: `Add-LocalGroupMember -Group "Remotedesktopbenutzer" -Member "Jeder"` fügt die Berechtigung für „Jeder“ zur Remote-Desktop-Gruppe hinzu.
7. **Disable some Telemetry**: Erstellt oder bearbeitet Registrierungseinträge, um Telemetrie und Feedback-Benachrichtigungen zu deaktivieren.
8. **Search Adjustments**: Anpassungen der Suche, um Cloudsuche und Cortana sowie webbasierte Suchanfragen zu deaktivieren.
9. **Disable Suggestions**: Deaktiviert Suchvorschläge im Datei-Explorer.
10. **RDP Settings**: Erlaubt Remote Desktop (RDP) Verbindungen und setzt die Sicherheitsstufe für RDP auf „Benutzerauthentifizierung deaktiviert“ und die „Sicherheitslayer“ auf 1.
11. **Disable Widgets**: Deaktiviert „News and Interests“-Widgets auf der Taskleiste.
12. **Hiberboot Off**: `Set-ItemProperty -Path ... -Name "HiberbootEnabled" -Value 0` deaktiviert den Schnellstart beim Herunterfahren.
13. **Disable Logon Background Image**: Deaktiviert das Hintergrundbild beim Anmeldebildschirm.
14. **Disable Lockscreen**: `New-ItemProperty -Path ... -Name "NoLockScreen" -Value 1` deaktiviert den Sperrbildschirm.
15. **Set Powerbutton to Shutdown**: `powercfg`-Befehle setzen den Power-Button (Netzschalter) auf die Aktion „Herunterfahren“.
16. **Restart Explorer**: `Stop-Process -Name "Explorer" -Force` startet den Explorer neu, um Änderungen wirksam zu machen.

Dieses Skript setzt umfassende System- und Benutzeranpassungen in Windows, um eine vereinfachte und fokussierte Umgebung zu schaffen, die Telemetrie und Ablenkungen minimiert und die Netzwerk- sowie Remotezugriffskonfiguration optimiert.

### Code

```powershell
# Set Windows Lanugage to de-AT
Set-WinSystemLocale de-AT
Set-WinUILanguageOverride -Language de-AT

# Enable Local Admin and disable W10 and W11
Enable-LocalUser "Administrator"
Disable-LocalUser "W10" -ErrorAction SilentlyContinue
Disable-LocalUser "W11" -ErrorAction SilentlyContinue
Get-LocalUser | Set-LocalUser -PasswordNeverExpires $true

# Disable IPv6
Disable-NetAdapterBinding -Name * -ComponentID "ms_tcpip6"

# Network Location Awareness to Delayed
sc.exe config NlaSvc start=delayed-auto

# Enable Firewall Rules
Enable-NetFirewallRule -DisplayGroup "Remotedesktop"
Enable-NetFirewallRule -DisplayGroup "Netzwerkerkennung"
Enable-NetFirewallRule -DisplayGroup "Datei- und Druckerfreigabe"

# Add Any to Remotedesktopbenutzer
Add-LocalGroupMember -Group "Remotedesktopbenutzer" -Member "Jeder" -ErrorAction SilentlyContinue

# Disable some Telemetry
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Force -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DisableOneSettingsDownloads" -Value 1 -Force -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Value 1 -Force -ErrorAction SilentlyContinue

# Search Adjustments
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCloudSearch" -Value 0 -Force -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Value 0 -Force -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortanaAboveLock" -Value 0 -Force -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowSearchToUseLocation" -Value 0 -Force -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "ConnectedSearchUseWeb" -Value 0 -Force -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "DisableWebSearch" -Value 1 -Force -ErrorAction SilentlyContinue

# Disable Suggestions
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value 1 -Force -ErrorAction SilentlyContinue

# RDP
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "UserAuthentication" -Value 0
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "SecurityLayer" -Value 1

# Disable Widgets
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Name "AllowNewsAndInterests" -Value 0 -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests" -Name "value" -Value 1

# Hiberboot Off
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 0

# Disable Logon Background Image
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "DisableLogonBackgroundImage" -Value 1 -Force -ErrorAction SilentlyContinue

# Disable Lockscreen
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name "NoLockScreen" -Value 1 -Force -ErrorAction SilentlyContinue

# Set Powerbutton to Shutdown
powercfg /setacvalueindex SCHEME_CURRENT SUB_BUTTONS PBUTTONACTION 3
powercfg /setdcvalueindex SCHEME_CURRENT SUB_BUTTONS PBUTTONACTION 3

# Restart Explorer
Stop-Process -Name "Explorer" -Force
```
