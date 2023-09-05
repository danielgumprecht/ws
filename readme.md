# Windows Deployment Tool
This tool is for internal purposes only and is not intended for the general public.

The goal is to streamline and simplify the deployment of new machines while minimizing human interaction.

### What it does
- Registers winget for installing general apps
- Sets system language to German (Austria)
- Enables the user "Administrator" while disabling "W10" and "W11"
- Enables remote desktop connection and allows every user to connect with remote desktop
- Enables network sharing and detection
- Makes multiple power configuration adjustments
- Disables lock screen, Windows Bing search, and hiberboot
- Adjusts remote desktop security
- Enables file extensions and sets classic right-click
- Installs 7zip, Chrome, Firefox, Acrobat Reader, PDFcreator, VLC, OpenJDK 8, OpenJDK 11, FortiClientVPN, and TeamViewerQS
- Enables feature NetFx3
- Copies the remote agent to desktop, and waits for installation before deleting the installer after the process ends.

### Steps remaining
- Set the PC name and label the PC
- To install customer software
- Install Office

# How to Execute?

1. Windows + X
2. Windows PowerShell (Administrator)
3. `irm gump.at/wdt | iex`
4. Enter