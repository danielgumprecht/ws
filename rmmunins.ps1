# Check if CWA service exists
if (Get-Service -Name "LTService" -ErrorAction SilentlyContinue) {

    Write-Host "CWA service exists. Launching script..."

    # kill N-Able tasks
    $tasks = @(
        "PME.Agent",
        "FileCacheServiceAgent",
        "RequestHandlerAgent",
        "ASupSrvc",
        "BASupSrvc",
        "BASupSrvcCnfg",
        "BASupSrvcUpdater",
        "Au_",
        "winagent"
    )

    foreach ($task in $tasks) {
    Get-Process -Name $task -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
    }

    # disable N-Able services
    $services = @(
        "PME.Agent.PmeService",
        "SolarWinds.MSP.CacheService",
        "SolarWinds.MSP.RpcServerService",
        "BASupportExpressStandaloneService_LOGICnow",
        "BASupportExpressSrvcUpdater_LOGICnow",
        "Advanced Monitoring Agent"
    )

    foreach ($service in $services) {
    Set-Service -Name $service -StartupType Disabled -ErrorAction SilentlyContinue
    }

    # Remove N-able install locations, also removes them from services.msc
    Remove-Item "C:\Program Files (x86)\Advanced Monitoring Agent GP\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\Program Files (x86)\Advanced Monitoring Agent\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\Program Files (x86)\Take Control Agent\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\Program Files (x86)\BeAnywhere Support Express\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\ProgramData\GetSupportService_Common_LOGICnow\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\ProgramData\GetSupportService_LOGICnow\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\ProgramData\GetSupportService\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\ProgramData\MspPlatform\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\ProgramData\MSPEcosystem\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\ProgramData\SolarWinds MSP\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\ProgramData\N-able\" -recurse -force -ErrorAction SilentlyContinue
    Remove-Item "C:\ProgramData\N-Able Technologies\" -recurse -force -ErrorAction SilentlyContinue

} else {

Write-Host "CWA not found. Stopping Script."

}

# Check if Paths still exist
$paths = @("C:\Program Files (x86)\Advanced Monitoring Agent GP\",
"C:\Program Files (x86)\Advanced Monitoring Agent\",
"C:\Program Files (x86)\Take Control Agent\",
"C:\Program Files (x86)\BeAnywhere Support Express\",
"C:\ProgramData\GetSupportService_Common_LOGICnow\",
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
        Write-Host "Path $path still exists. Reboot and relaunch the scipt to finish deletion"
    } else {
        Write-Host "$path has been cleaned"
    }
}