# N-Able Remote Monitoring & Management - Removal Skript

## Run
1.	Press Windows + X. A black menu with shortcuts to various settings opens on the taskbar.
2.	Click PowerShell (Administrator).
3.	Type irm gump.at/rmm | iex and press Enter.
4.	This script checks whether CWA is installed, then removes the remote monitoring and all related services.

## Details
1.	Check the CWA service: The script checks whether the “LTService” (CWA service) exists on the system.
2.	Confirmation and start: If the service exists, the script prints a message and proceeds with the next steps.
3.	Terminate N-able processes: It iterates through a list of N-able-related processes (e.g., “PME.Agent”, “FileCacheServiceAgent”, “winagent”) and terminates each one found.
4.	Disable N-able services: It iterates through another list of N-able-related services and sets their startup type to “Disabled.”
5.	Delete N-able installation directories: The script removes all relevant installation paths for N-able and related programs. This is done recursively and forcefully to delete all files in those directories.
6.	Verify remaining paths: After deletion, the script checks whether those paths still exist. If any path remains, the script reports that a reboot and a rerun are required to complete removal.
7.	Exit if no CWA service: If the CWA service “LTService” is not found, the script prints a message and exits.

## Execution

- press `Windows + R` on Keyboard > on the Bottom left Windows Run Prompt opens
- type `powershell` then press `Shift + Control + Enter` > opens Powershell with elevated Permissions
- In Powershell type `irm gump.at/rmm | iex` > executes the .ps1 script from `https://raw.githubusercontent.com/danielgumprecht/ws/refs/heads/main/rmm.ps1`