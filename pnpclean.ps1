Get-PnpDevice | Where-Object { $_.Present -eq $false } | ForEach-Object {
    pnputil /remove-device "$($_.InstanceId)"
}
