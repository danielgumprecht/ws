# nlafix

## This PowerShell script does the following:

1.	Enable and start services: It iterates through a list of services (RpcSs, SSDPSRV, upnphost). Each service is set to start automatically at system startup, then the service is started.
2. Set firewall rules: The Windows Firewall rules for “Network Discovery” and “File and Printer Sharing” are enabled to allow network features and shares.
3.	Set dependencies for the NLA service: nlasvc (Network Location Awareness) is configured to depend on several other services (NSI, RpcSs, TcpIp, Dhcp, Eventlog, DNS). This ensures these dependencies are available when NLA starts.

## Technical explanation

- Sets three services to Automatic that Network Discovery depends on, then starts them in the correct order > activates the services required for Network Discovery.
- Re-enables all firewall rules for Network Discovery and File and Printer Sharing > ensures Network Discovery is actually enabled.
- Adds DNS as an additional dependency for the Network Location Awareness service > improves the reliability of Network Discovery, since DNS must be running for NLA to detect the correct network environment (if the network location is incorrect, the NLA service needs a restart after these changes).

## Execution

Important Note: This scipt should be only executed on Active Directory Domain Controllers. If you want to still execute it on non DC Windows Servers please remove the last line from the ps1 file: `sc.exe config nlasvc depend= NSI/RpcSs/TcpIp/Eventlog/DNS`

- press `Windows + R` on Keyboard > on the Bottom left Windows Run Prompt opens
- type `powershell` then press `Shift + Control + Enter` > opens Powershell with elevated Permissions
- In Powershell type `irm gump.at/nlafix | iex` > executes the .ps1 script from `https://raw.githubusercontent.com/danielgumprecht/ws/refs/heads/main/nlafix.ps1`