# Windows Scripts

This tool is for internal purposes only and is not intended for the general public.

Ziel ist es, das setzen diverser Einstellungen zu vereinfachen und zu optimieren und dabei die Interaktion mit dem Benutzer zu minimieren.

### Skripte

Das Repository besteht aus mehreren unterschiedlichen Skripten

- ads.ps1 - Installiert Active Directory Services, DHCP und DNS Server, und justiert diverse Einstellungen. Dieser Skript ist für Windows Server gemacht.
- basic.ps1 - Dieser Skript ist als Administrator auszuführen, da dieser Maschinenbezogene änderungen vornimmt, um Windows zuverlässiger, leicher zu Verwalten und weniger aufdringlich macht.
- das.ps1 - Nimmt alle Programme aus dem Autostart.
- lang.ps1 - Setzt die Windows Sprache auf de-AT. Dieser Skript ist mit und ohne Admin auszuführen.
- nfr.ps1 - Network Firewall Rules: aktiviert Netzwerkerkennung, Remotedesktop und die Datei- und Druckerfreigabe.
- sec.ps1 - Security: Deaktiviert alte TLS Versionen und SMB1
- srv.ps1 - Deinstalliert Defender, intalliert NetFX3, deaktiviert Server Manager Autostart und justiert die Internet Explorer Sicherheitseinstellungen. Dieser Skript ist für Windows Server gemacht.
- usr.ps1 - Userbezogener Skript, der die Windows Oberfläche weniger aufdringlich macht. Dieser Skript ist ohne Admin auszuführen.
- wdt.ps1 - Windows Deployment Tool: Für neue Clients, macht alles was basic.ps1 tut, aber installiert auch noch einige Programme und stellt die powercfg auf High Performance Plan um.

# Wie ausführen?

Um das Tool auszuführen, folgen Sie diesen Schritten:

1. Drücken Sie Windows + X
2. Wählen Sie Windows PowerShell (Administrator) / Terminal (Administrator)
3. Geben Sie zum Beispiel `irm gump.at/basic | iex` ein
4. Drücken Sie Enter