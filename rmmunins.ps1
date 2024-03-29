# kill N-Able services
$tasksToKill = @("PME.Agent", "FileCacheServiceAgent", "RequestHandlerAgent", "ASupSrvc", "BASupSrvcUpdater", "winagent")

foreach ($task in $tasksToKill) {
    Get-Process -Name $task -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction Continue
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
    Set-Service -Name $service -StartupType Disabled -ErrorAction Continue
}

# Remove N-able install locations, also removes them from services.msc
Remove-Item "C:\Program Files (x86)\Advanced Monitoring Agent GP\" -recurse -force -ErrorAction SilentlyContinue
Remove-Item "C:\Program Files (x86)\Advanced Monitoring Agent\" -recurse -force -ErrorAction SilentlyContinue
Remove-Item "C:\Program Files (x86)\Take Control Agent\" -recurse -force -ErrorAction SilentlyContinue

