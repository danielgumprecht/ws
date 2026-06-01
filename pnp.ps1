Write-Output "Removing non-present PnP devices." -ForegroundColor Cyan


Get-PnpDevice | Where-Object { $_.Present -eq $false } | ForEach-Object {
    pnputil /remove-device "$($_.InstanceId)"
}

Write-Output "Non-present PnP devices removed. Please review the output above for details." -ForegroundColor Green