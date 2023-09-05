# Windows Deployment Tool

This tool is for internal purposes only and is not intended for the general public.

Ziel ist es, die Bereitstellung neuer Maschinen zu vereinfachen und zu optimieren und dabei die Interaktion mit dem Benutzer zu minimieren.

### Was es tut

Das Tool führt die folgenden Aktionen aus:

- Registriert Winget für die Installation von den default Programmen
- Setzt die Systemsprache auf Deutsch (Österreich)
- Aktiviert den Benutzer "Administrator", und deaktiviert W10 und W11
- Aktiviert die Remote-Desktop-Verbindung und erlaubt jedem Benutzer die Verbindung mit Remote-Desktop
- Aktiviert die Netzwerkfreigabe und -erkennung
- Führt mehrere Anpassungen der Energiekonfiguration durch
- Deaktiviert den Sperrbildschirm, Windows Bing-Suche und Schnellstart
- Passt die Remote-Desktop-Sicherheit an
- Aktiviert Dateierweiterungen
- Setzt das klassische Rechtsklickmenü (Windows 11)
- Installiert 7zip, Chrome, Firefox, Acrobat Reader, PDFcreator, VLC, OpenJDK 8, OpenJDK 11, FortiClientVPN und TeamViewerQS
- Aktiviert NET Framework 3.5
- Kopiert den Remote-Agenten auf den Desktop und wartet auf die Installation, bevor der Installer nach Abschluss des Prozesses gelöscht wird.

### Verbleibende Schritte

Die folgenden Schritte müssen noch ausgeführt werden:

- Setzen des PC-Namens und Beschriftung des PCs
- Installation der Kundensoftware
- Installation von Office

# Wie ausführen?

Um das Tool auszuführen, folgen Sie diesen Schritten:

1. Drücken Sie Windows + X
2. Wählen Sie Windows PowerShell (Administrator) / Terminal (Administrator)
3. Geben Sie `irm gump.at/wdt | iex` ein
4. Drücken Sie Enter

Beachten Sie, dass dieses Tool nur einwandfrei funktioniert, wenn der PC im richtigen Netzwerk ist, da es auch auf eine Netzwerkfreigabe zugreift.