Write-Host "Removing non-present PnP devices." -ForegroundColor Cyan


Get-PnpDevice | Where-Object { $_.Present -eq $false } | ForEach-Object {
    pnputil /remove-device "$($_.InstanceId)"
}

Get-PnpDevice -FriendlyName OneNote -ErrorAction SilentlyContinue | ForEach-Object {
    pnputil /remove-device "$($_.InstanceId)"
}

Get-PnpDevice -FriendlyName "OneNote for Windows 10" -ErrorAction SilentlyContinue | ForEach-Object {
    pnputil /remove-device "$($_.InstanceId)"
}

Get-PnpDevice -FriendlyName "OneNote (Desktop)" -ErrorAction SilentlyContinue | ForEach-Object {
    pnputil /remove-device "$($_.InstanceId)"
}

Get-PnpDevice -FriendlyName "An OneNote 16 senden" -ErrorAction SilentlyContinue | ForEach-Object {
    pnputil /remove-device "$($_.InstanceId)"
}

Write-Host "Non-present PnP devices removed. Please review the output above for details." -ForegroundColor Green