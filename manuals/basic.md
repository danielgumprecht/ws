# Here is a detailed explanation of each step in the script:

1.	Set Windows language to de-AT: sets the system language and UI language to German (Austria).
2.	Enable Local Admin and disable W10 and W11: enables the built-in Administrator account, disables the user accounts “W10” and “W11” if present, and sets PasswordNeverExpires to true for all users.
3.	Disable IPv6: Disable-NetAdapterBinding -Name * -ComponentID "ms_tcpip6" disables IPv6 on all network interfaces.
4.	Network Location Awareness to Delayed: sc.exe config NlaSvc start=delayed-auto sets the Network Location Awareness service to “delayed start” to prevent an incorrect location.
5.	Enable Firewall Rules: enables firewall rules for Remote Desktop, network sharing, and file/printer sharing.
6.	Add Any to Remote Desktop Users: Add-LocalGroupMember -Group "Remotedesktopbenutzer" -Member "Jeder" grants “Everyone” membership in the Remote Desktop Users group.
7.	Disable some telemetry: creates or edits registry entries to disable telemetry and feedback notifications.
8.	Search adjustments: modifies search to disable cloud search, Cortana, and web-based queries.
9.	Disable suggestions: disables search suggestions in File Explorer.
10.	RDP settings: allows Remote Desktop (RDP) connections and sets the RDP security level to “user authentication disabled” and the “security layer” to 1.
11.	Disable widgets: disables “News and Interests” widgets on the taskbar.
12.	Hiberboot off: Set-ItemProperty -Path ... -Name "HiberbootEnabled" -Value 0 disables Fast Startup on shutdown.
13.	Disable logon background image: disables the background image on the sign-in screen.
14.	Disable lock screen: New-ItemProperty -Path ... -Name "NoLockScreen" -Value 1 disables the lock screen.
15.	Set power button to Shutdown: powercfg commands set the power button action to “Shut down.”
16.	Restart Explorer: Stop-Process -Name "Explorer" -Force restarts Explorer to apply changes.

This script applies extensive Windows system and user customizations to create a simplified, focused environment that minimizes telemetry and distractions and optimizes network and remote access configuration.

# Execution

Note: This Script was tested in Windows 10 and 11. On Windows 10 or on Home editions there are some Error messages for not existing Settings.

- press `Windows + R` on Keyboard > on the Bottom left Windows Run Prompt opens
- type `powershell` then press `Shift + Control + Enter` > opens Powershell with elevated Permissions
- In Powershell type `irm gump.at/basic | iex` > executes the .ps1 script from `https://raw.githubusercontent.com/danielgumprecht/ws/refs/heads/main/basic.ps1`